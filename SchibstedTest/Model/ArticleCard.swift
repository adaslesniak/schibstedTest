// ArticleCard.swift [SchibstedTest] created by: Adas Lesniak on: 01/04/2019 
// Copyright ©Aulendil   All rights reserved.
import UIKit


public class ArticleCard {
    
    public private(set) var id: String = ""
    public private(set) var title: String = ""
    public private(set) var imageId: String = ""
    
    enum SerialisationKeys : String {
        case title = "title.value"
        case id = "article_id"
        case imageId = "main_resource.image_asset.id"
    }
    
    //if I were to be super strict about separating UI and data, could return image data, but... UIImage differes from UI piece
    public func getImage(_ whenReady: @escaping (UIImage?) -> Void) {
        Backend.getImageForArticle(imageId: imageId, whenReady: whenReady)
    }
    
    public static func  fromJson(_ serialised: JsonDictionary) -> ArticleCard? {
        do {
            guard let theId = serialised.valueAtPath(SerialisationKeys.id.rawValue) as? String else {
                throw Exception.error("no id")
            }
            guard let theTitle = serialised.valueAtPath(SerialisationKeys.title.rawValue) as? String else {
                throw Exception.error("no title")
            }
            guard let theImage = serialised.valueAtPath(SerialisationKeys.imageId.rawValue) as? String else {
                throw Exception.error("no image id")
            }
            let card = ArticleCard()
            card.id = theId
            card.title = theTitle
            card.imageId = theImage
            return card
        } catch {
            print("ERROR no proper log to log ArticleCard deserialisation error: \(error)")
            return nil
        }
    }

    private init() { }
    
}
