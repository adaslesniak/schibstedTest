// [UnitTestsOf_SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import Foundation
import XCTest

@testable import SchibstedTest
class TestOf_ArticleCard: XCTestCase {
    
    //TODO: move test data outside to some file
    func test_fromJson() {
        func assertIsCreated(_ param: JsonDictionary) {
            XCTAssertNotNil(ArticleCard.fromJson(param))
        }
        func assertIsNotCreated(_ param: JsonDictionary) {
            XCTAssertNil(ArticleCard.fromJson(param))
        }
        
        let minimalProperParam: JsonDictionary = [
            "title" : [ "value" : "someArticleTitle"],
            "article_id" : "someArticleId",
            "main_resource" : [ "image_asset" : ["id" : "someArticleImageId"]]
            ]
        assertIsCreated(minimalProperParam)
        let missingIdParam: JsonDictionary = [
            "title" : [ "value" : "someArticleTitle"],
            "wrong_id_key" : "someArticleId",
            "main_resource" : [ "image_asset" : ["id" : "someArticleImageId"]]
        ]
        assertIsNotCreated(missingIdParam)
        let missingTitleField: JsonDictionary = [
            "wrong_title_key" : [ "value" : "someArticleTitle"],
            "article_id" : "someArticleId",
            "main_resource" : [ "image_asset" : ["id" : "someArticleImageId"]]
        ]
        assertIsNotCreated(missingTitleField)
        let missingTitleParam: JsonDictionary = [
            "title" : [ ],
            "article_id" : "someArticleId",
            "main_resource" : [ "image_asset" : ["id" : "someArticleImageId"]]
        ]
        assertIsNotCreated(missingTitleParam)
        let missingMainResourceField: JsonDictionary = [
            "title" : [ "value" : "someArticleTitle"],
            "article_id" : "someArticleId",
            "wrong_main_resource_key" : [ "image_asset" : ["id" : "someArticleImageId"]]
        ]
        assertIsNotCreated(missingMainResourceField)
        let missingImageAssetField: JsonDictionary = [
            "title" : [ ],
            "article_id" : "someArticleId",
            "main_resource" : [ "image_asset" : ["id" : "someArticleImageId"]]
        ]
        assertIsNotCreated(missingImageAssetField)
        let missingImageIdParam: JsonDictionary = [
            "title" : [ "value" : "someArticleTitle"],
            "article_id" : "someArticleId",
            "main_resource" : [ "image_asset" : []]
        ]
        assertIsNotCreated(missingImageIdParam)
        let validParamWithAdditionalData: JsonDictionary = [
            "title" : [ "value" : "someArticleTitle", "spam" : 9],
            "crap" : 34.5,
            "article_id" : "someArticleId",
            "main_resource" : [ "image_asset" : ["id" : "someArticleImageId", "nothingThatMatters" : false], "trash": "0000"],
            "secondaryResources" : "who cares"
        ]
        assertIsCreated(validParamWithAdditionalData)
    }
    
}


