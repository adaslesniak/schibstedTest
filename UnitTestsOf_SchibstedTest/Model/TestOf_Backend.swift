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
    
    func test_getArticle() {
        var expectations = [XCTestExpectation]()
        func addTestCase(articleId: String, isValid: Bool) {
            let requirement = XCTestExpectation(description: "test case for article with id: \(articleId) [valid?=\(isValid)]")
            expectations.append(requirement)
            Backend.getArticle(articleId) { result in
                let isFound = result != nil
                XCTAssert(isFound == isValid, requirement.description)
                requirement.fulfill()
            }
        }
        addTestCase(articleId: "rAr4OK", isValid: true)
        addTestCase(articleId: "", isValid: false)
        addTestCase(articleId: "fake_id", isValid: false)
        addTestCase(articleId: "qL68Oe", isValid: true)
        addTestCase(articleId: "OpkXdO", isValid: true)
        
        wait(for: expectations, timeout: 1.9)
    }
    
    func test_getTopic() {
        var expectations = [XCTestExpectation]()
        func addTest(id topicId: String, isValid: Bool) {
            let requirement = XCTestExpectation(description: "topic: \(topicId) [valid?=\(isValid))")
            expectations.append(requirement)
            Backend.getTopic(topicId) { result in
                let isFound = result != nil
                XCTAssert(isFound == isValid, requirement.description)
                requirement.fulfill()
            }
        }
        addTest(id: "2993a182-1317-4ad9-8a27-36416ca49c9f", isValid: true)
        addTest(id: "826e966b-14bd-461e-8585-19f41d1465d6", isValid: true)
        addTest(id: "", isValid: false)
        addTest(id: "ad67597d-1ef1-4066-82e1-b5ab8052f7a2", isValid: true)
        addTest(id: "fake_id", isValid: false)
        
        wait(for: expectations, timeout: 2.1)
    }
}
