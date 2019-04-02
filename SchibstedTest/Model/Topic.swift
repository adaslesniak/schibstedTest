// [SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import Foundation


public class Topic {

    public private(set) var type: String = ""
    public private(set) var title: String = ""
    public private(set) var id: String = ""
    
    public static func fromJson(_ serialised: JsonDictionary) -> Topic? {
        do {
            guard let typeFiled = serialised.valueAtPath("type") else {
                throw Exception.error("no type")
            }
            guard let theId = serialised.valueAtPath("topic_id") as? String else {
                throw Exception.error("no id")
            }
            guard let theTitle = serialised.valueAtPath("title") as? String else {
                throw Exception.error("no title")
            }
            let new = Topic()
            new.type = "\(typeFiled)"
            new.title = theTitle
            new.id = theId
            return new
        } catch {
            print("ERROR no proper log, no topic: \(error)")
            return nil
        }
    }
    
    private init() { }
}
