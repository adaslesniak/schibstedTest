// [SchibstedTest] created by: Adas Lesniak on: 01/04/2019
import Foundation


//contains list of Topics and articles
public class ContentList {
    
    public private(set) var articles = [ArticleCard]()
    public private(set) var topics = [TopicCard]()
    
    //probably could use RxSwift, but never managed to learn that after super unpleasand debugging session with RxObjective-C
    //could also work with Notifications, but they are globals and that is... I just really dislike global solutions
    typealias Listener = (owner: AnyObject, action: Action)
    private var articlesEventListeners = [Listener]()
    private var topicsEventListeners = [Listener]()
    
    public func updateAboutArticles(_ who: AnyObject, action: @escaping Action) {
        articlesEventListeners.append((who, action))
    }
    
    public func updateAboutTopics(_ who: AnyObject, action: @escaping Action) {
        topicsEventListeners.append((who, action))
    }
    
    public func unregisterFromUpdates(_ who: AnyObject) {
        while true { //TODO: refactor me, while true is just plain ugly and lot of duplicated code
            var iInvalid: Int? = nil //i at first place stands for index - just like in classic for(int "i")
            for (i, listener) in articlesEventListeners.enumerated() {
                if listener.owner === who {
                    iInvalid = i
                    break
                }
            }
            if let iInvalid = iInvalid {
                articlesEventListeners.remove(at: iInvalid)
            } else {
                break
            }
        }
        while true {
            var iInvalid: Int? = nil
            for (i, listener) in topicsEventListeners.enumerated() {
                if listener.owner === who {
                    iInvalid = i
                    break
                }
            }
            if let iInvalid = iInvalid {
                topicsEventListeners.remove(at: iInvalid)
            } else {
                break
            }
        }
    }
    
    func pullFromServer() {
        Backend.getArticlesList { [weak self] answer in
            Log.debug("got \(answer.count) articles")
            ExecuteOnMain { [weak self] in
                self?.articles = answer
                self?.articlesEventListeners.forEach({$0.action()})
            }
        }
        Backend.getTopicsList { [weak self] answer in
            Log.debug("got \(answer.count) topics")
            ExecuteOnMain { [weak self] in
                self?.topics = answer
                self?.topicsEventListeners.forEach({$0.action()})
            }
        }
    }
}
