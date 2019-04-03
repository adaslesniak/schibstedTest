// [SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import Foundation


public class Article {
    
    public private(set) var text = ""
    public private(set) var title = ""
    public private(set) var id = ""
    public private(set) var authors = [String]() //lazy, there should be proper struct for authors
    
    
    public static func fromJson(_ serialised: JsonDictionary) -> Article? {
        do {
            let new = Article()
            guard let body = serialised.valueAtPath("main_text.paragraphs") as? [JsonDictionary] else {
                throw Exception.error("no text")
            }
            guard let theTitle = serialised.valueAtPath("title.value") as? String else {
                throw Exception.error("no title")
            }
            guard let theId = serialised.valueAtPath("article_id") as? String else {
                throw Exception.error("no id")
            }
            guard let theAuthors = serialised.valueAtPath("authors") as? [JsonDictionary] else {
                throw Exception.error("no authors")
            }
            new.id = theId
            new.title = theTitle
            var theText = "" //TODO: test it, may be slow, maybe some StringBuilder required
            body.forEach({ theText += "   \($0.valueAtPath("text.value") as? String ?? "")\n" }) //TODO: refactor - it's too complicated for single line, hard to read
            new.text = "\(theText)" //TODO it's just NOT_IMPLEMENTED
            new.authors = theAuthors.map({return $0.valueAtPath("title") as? String ?? "anonymous" })
            return new
        } catch {
            Log.error("couldn't deserialise article: \(error)\n   data:  \(serialised)")
            return nil
        }
    }
    private init() { }
    
}
