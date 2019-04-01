// ArticleCard.swift [SchibstedTest] created by: Adas Lesniak on: 01/04/2019 
// Copyright ©Aulendil   All rights reserved.
import UIKit


public class ArticleCard {
    
    public private(set) var id: String = ""
    public private(set) var title: String = ""
    private var icon: URL? = nil
    
    //if I were to be super strict about separating UI and data, could return image data, but... UIImage differes from UI piece
    public func getImage(_ whenReady: @escaping (UIImage?) -> Void) {
        fatalError("NOT_IMPLEMENTED")
    }
    
    public static func  fromSerialised(_ serialised: String) -> ArticleCard {
        fatalError("NOT_IMPLEMENTED")
    }

    private init() { }
    
}
