// [UnitTestsOf_SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import Foundation
import XCTest

@testable import SchibstedTest
class TestOf_ContentList: XCTestCase {
    
    func test_updateAboutArticles() {
        let assumption1 = XCTestExpectation(description: "was updated about articles")
        let assumption2 = XCTestExpectation(description: "was also updated about articles")
        let list = ContentList()
        list.updateAboutTopics(self) {
            assumption1.fulfill()
        }
        let placeholder = ContentList() //whatever object
        list.updateAboutTopics(placeholder) {
            assumption2.fulfill()
        }
        list.pullFromServer() //to trigger some update
        
        wait(for: [assumption1, assumption2], timeout: 2.5)
    }
    
    func test_updateAboutTopics() {
        let assumption1 = XCTestExpectation(description: "was updated about topics")
        let assumption2 = XCTestExpectation(description: "was also updated about topics")
        let list = ContentList()
        list.updateAboutTopics(self) {
            assumption1.fulfill()
        }
        let placeholder = ContentList()
        list.updateAboutTopics(placeholder) {
            assumption2.fulfill()
        }
        list.pullFromServer() //to force some update
        
        wait(for: [assumption1, assumption2], timeout: 2.5)
    }
    
}
