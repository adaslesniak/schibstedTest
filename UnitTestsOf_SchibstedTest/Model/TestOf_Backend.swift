// TestOf_Backend.swift [UnitTestsOf_SchibstedTest] created by: Adas Lesniak on: 02/04/2019 
// Copyright ©Aulendil   All rights reserved.

import Foundation
import XCTest

@testable import SchibstedTest
class TestOf_Backend: XCTestCase {
    
    func test_getImageForArticle() {
        let assumption1 = XCTestExpectation(description: "got image for valid case 1")
        let imgId1valid = "312e2e7f-1da4-43bd-98ed-ee14f8e884fa"
        Backend.getImageForArticle(imageId: imgId1valid) { result in
            XCTAssertNotNil(result)
            assumption1.fulfill()
        }
        
        let assumption2 = XCTestExpectation(description: "got image for valid case 2") //multiple as it's good to run few at once
        let imgId2valid = "312e2e7f-1da4-43bd-98ed-ee14f8e884fa"
        Backend.getImageForArticle(imageId: imgId2valid) { result in
            XCTAssertNotNil(result)
            assumption2.fulfill()
        }
        
        let assumption3 = XCTestExpectation(description: "got no image for invalid case 3")
        let imgId3invalid = "wrong_image_asset_id"
        Backend.getImageForArticle(imageId: imgId3invalid) { result in
            XCTAssertNil(result)
            assumption3.fulfill()
        }
        
        let assumption4 = XCTestExpectation(description: "got no image for empty case 4")
        let imgId4empty = ""
        Backend.getImageForArticle(imageId: imgId4empty) { result in
            XCTAssertNil(result)
            assumption4.fulfill()
        }
        wait(for: [assumption1, assumption2, assumption3, assumption4], timeout: 7)
    }
}
