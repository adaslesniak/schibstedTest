// [SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import Foundation


//"card" in my convention stands for brief info, like library card about book, business card about person - short info with basic details
public class TopicCard {
    
    public private(set) var id: String = ""
    public private(set) var title: String = ""
    
    
    public static func fromJson(_ serialised: JsonDictionary) -> TopicCard? {
        let card = TopicCard()
        guard let theId = serialised.valueAtPath("topic_id") as? String,
            let theTitle = serialised.valueAtPath("title") as? String else {
                Log.error("failed to deserialisie TopicCard")
                return nil
        }
        card.id = theId
        card.title = theTitle
        return card
    }
    private init() {}
    
}
