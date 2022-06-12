import XCTest
@testable import lostfilm

// https://developer.apple.com/documentation/xctest/user_interface_tests
// https://habr.com/ru/company/vivid_money/blog/533180/
class lostfilmUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AccessEveryTabBarScreenByClickingTabButtons() throws {
        let tabBar = app.tabBars["Панель вкладок"]
        tabBar.buttons["News"].tap()
        let newsHeader = app.staticTexts["News"]
        XCTAssertTrue(newsHeader.exists)
        tabBar.buttons["Videos"].tap()
        let videosHeader = app.staticTexts["Videos"]
        XCTAssertTrue(videosHeader.exists)
        tabBar.buttons["New Episodes"].tap()
        let newEpsHeader = app.staticTexts["New Episodes"]
        XCTAssertTrue(newEpsHeader.exists)
        tabBar.buttons["Schedule"].tap()
        let scheduleHeader = app.staticTexts["Schedule"]
        XCTAssertTrue(scheduleHeader.exists)
        tabBar.buttons["TV Series"].tap()
        let seriesHeader = app.staticTexts["TV Series"]
        XCTAssertTrue(seriesHeader.exists)
    }
    
    func test_GlobalSearchShowsRelevantResponse() throws {
        // MARK: Given
        let searchButton = app.navigationBars["TV Series"].children(matching: .button).firstMatch
        let searchField = app.navigationBars["lostfilm.GlobalSearchTVC"].searchFields["Search"]
        searchButton.tap()
        
//        let hasFocusPredicate = NSPredicate(format: "hasFocus == true")
        
//        let hasFocusPredicate = NSPredicate(value: searchField.value(forKey: "hasKeyboardFocus") as! Bool)
//        let searchFieldHasFocusExpectation = XCTNSPredicateExpectation(predicate: hasFocusPredicate, object: searchField)
//        wait(for: [searchFieldHasFocusExpectation], timeout: 3)
        // MARK: When
                searchField.typeText("Lost")
        // MARK: Then
        let cellIsPresent = expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: app/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Lost")/*[[".cells.containing(.staticText, identifier:\"Остаться в живых\")",".cells.containing(.staticText, identifier:\"Lost\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch)
        wait(for: [cellIsPresent], timeout: 5)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
