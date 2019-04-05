// [SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import Foundation
import UIKit //not sure about that, maybe should just return file?

//this class is a little mess as it defines what API should be like. It's not real API definition, it's more a wrapper around it - to make it properly I would need to work with designer/product manager
class Backend {
    
    static func getArticlesList(_ whenReady: @escaping ([ArticleCard]) -> Void) {
        getMassiveJson { result in
            guard let articlesData = result.valueAtPath("articles") as? [JsonDictionary] else { //TODO: hate this string, use enums for keys
                Log.error("couldn't get articles in: \(result)")
                return
            }
            var articles = [ArticleCard]()
            for piece in articlesData {
                if let card = ArticleCard.fromJson(piece) {
                    articles.append(card)
                }
            }
            whenReady(articles)
        }
    }
    
    static func getTopicsList(_ whenReady: @escaping ([TopicCard]) -> Void) {
        getMassiveJson { result in
            guard let topicsData = result.valueAtPath("topics") as? [JsonDictionary] else  {
                Log.error("couldn't get articles in: \(result)")
                return
            }
            var topics = [TopicCard]()
            for piece in topicsData {
                guard let card = TopicCard.fromJson(piece) else {
                    Log.error("deserialisation of TopicCard")
                    continue
                }
                topics.append(card)
            }
            whenReady(topics)
        }
    }
    
    static func getImageForArticle(imageId: String, whenReady: @escaping (UIImage?) -> Void) {
        guard let requestUrl = URL(string: "https://gfx-ios.omni.se/images/\(imageId)")  else {
            Log.error("when creating image request")
            whenReady(nil)
            return
        }
        //TODO: should use some FileCache 
        var request = URLRequest(url: requestUrl)
        request.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        executeRequest(request) { data, response in
            do {
                guard let data = data else {
                    throw Exception.error("no data")
                }
                guard let image = UIImage(data: data) else {
                    throw Exception.error("ERROR: no... couldn't create image from returned data ")
                }
                whenReady(image)
            } catch {
                Log.error("couldn't create image for request: \(requestUrl)")
                whenReady(nil)
            }
        }
    }
    
    public static func getArticle(_ articleId: String, whenReady: @escaping (Article?) -> Void) {
        getMassiveJson { everything in
            do {
                guard let articlesData = everything.valueAtPath("articles") as? [JsonDictionary] else {
                    throw Exception.error("no articles")
                }
                guard let theData = articlesData.first(where: { ($0.valueAtPath("article_id") as? String) == articleId }) else {
                    //that's ugly ninja hardcoded key and whole expression is barely readable
                    throw Exception.error("couldn't find article with id: \(articleId)")
                }
                guard let theArticle = Article.fromJson(theData) else {
                    throw Exception.error("couldn't deserialise")
                }
                whenReady(theArticle)
            } catch {
                Log.error("couldn't get article: \(error)")
                whenReady(nil)
            }
        }
    }
    
    public static func getTopic(_ topicId: String, whenReady: @escaping  (Topic?) -> Void) {
        getMassiveJson { everything in
            do {
                guard let topics = everything.valueAtPath("topics") as? [JsonDictionary] else {
                    throw Exception.error("no topics")
                }
                guard let theData = topics.first(where: { ($0.valueAtPath("topic_id") as? String) == topicId} ) else {
                    throw Exception.error("no such topic")
                }
                guard let theTopic = Topic.fromJson(theData) else {
                    throw Exception.error("junk data")
                }
                whenReady(theTopic)
            } catch {
                Log.error("wrong topic(\(topicId)) Error: \(error)")
                whenReady(nil)
            }
        }
    }
    
    
    private static var massiveJsonCache: (Date, JsonDictionary)?
    private static func getMassiveJson(_ whenDone: @escaping (JsonDictionary) -> Void) {
        if let cached = massiveJsonCache, cached.0.timeIntervalSinceNow < 15 {
            whenDone(cached.1)
            return
        }
        //TODO: some persistence would be reasonable - but then do we really need them stored on device and not refreshed. That is a matter of policy, design, not implementation detail
        let request = unauthorizedJsonRequest("https://omni-content.omni.news/search?query=stockholm")
        executeRequest(request, errorHandling: {
            Log.error("could not execute reuqest request")
        }) { data, response in
            guard let details = JsonDictionary(jsonData: data) else {
                Log.error("something really wrong here: \n\(String(describing: response)) \(String(describing: data)))")
                return
            }
            massiveJsonCache = (Date(), details)
            whenDone(details)
        }
    }
    
    
    //==============================================================
    //======== generic private stuff for dealing with REST =========
    private static func unauthorizedJsonRequest(_ endpoint: String) -> URLRequest {
        guard let api = URL(string: endpoint)  else {
            fatalError("ERROR: wrong string for making url request: \(endpoint)")
        }
        var request = URLRequest(url: api)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    typealias AnswerProcessing = (Data?, URLResponse?) throws -> Void
    private static func executeRequest(_ theRequest: URLRequest, errorHandling: Action? = nil, _ answerProcessing: @escaping AnswerProcessing) {
        var isDone = false
        ExecuteInBackground(after: 90) {
            if !isDone {
                isDone = true
                Log.warning("request timed out: \(theRequest.url?.absoluteString ?? "nil")")
                errorHandling?()
            }
        }
        ExecuteInBackground {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let job = session.dataTask(with: theRequest) { data, response, error in
                do {
                    guard !isDone else {
                        Log.warning("answer took way too long, request already timed out")
                        return
                    }
                    guard error == nil else {
                        throw Exception.error("answer has an error: \(error!)")
                    }
                    try answerProcessing(data, response)
                    isDone = true
                } catch {
                    Log.warning("failed to executeRequest: [\(theRequest)]: \n\(error)")
                    errorHandling?()
                }
                isDone = true
            }
            job.resume()
        }
    }
    
}
