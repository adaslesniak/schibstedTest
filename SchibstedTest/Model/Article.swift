// [SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import Foundation


class Article {
    
    public private(set) var text = JsonDictionary()
    public private(set) var title: String = ""
    public private(set) var id: String = ""
    public private(set) var authors = [String]() //lazy, there should be proper struct for authors
    
    
    public static func fromJson(_ serialised: JsonDictionary) -> Article? {
        do {
            let new = Article()
            guard let theText = serialised.valueAtPath("main_text") as? JsonDictionary else {
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
            new.text = theText
            new.authors = theAuthors.map({return $0.valueAtPath("title") as? String ?? "anonymous" })
            return new
        } catch {
            var keysDscr = "keys are:  "
            serialised.forEach({ keysDscr = keysDscr + $0.key + "; "})
            print("ERROR: no log... couldn't deserialise article: \(error)\n    \(keysDscr)")
            return nil
        }
    }
    private init() { }
    
}
