import XCTest
@testable import lostfilm

// https://www.raywenderlich.com/21020457-ios-unit-testing-and-ui-testing-tutorial
class lostfilmTests: XCTestCase {
    var sut: GlobalSearchProtocol?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = GlobalSearchDC()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_API_getGlobalSearchOutputFor() {
        // MARK: Given
        let searchContext = "Lost"
        let promiseForSeriesList = expectation(description: "SeriesList contains searchContext: \"\(searchContext)\"")
        let promiseForPersonList = expectation(description: "PersonList contains searchContext: \"\(searchContext)\"")
        let promiseForError = expectation(description: "Error is nil")
        let comparisonClosure: (String) -> Bool = { str in
                str.range(of: searchContext, options: .caseInsensitive) != nil
        }
        var response: (([LFSeriesModel]?, [LFPersonModel]?, NSError?) -> Void)?
        // MARK: When
        sut?.getGlobalSearchOutputFor(searchContext: searchContext) { seriesList, personList, error in
            response?(seriesList, personList, error)
        }
        // MARK: Then
        response = {seriesList, personList, error in
            if let seriesList = seriesList, seriesList.contains(where: { comparisonClosure($0.nameEn) }) {
                promiseForSeriesList.fulfill()
            }
            if let personList = personList, personList.contains(where: { comparisonClosure($0.nameEn) }) {
                promiseForPersonList.fulfill()
            }
            if error == nil {
                promiseForError.fulfill()
            }
        }
        wait(for: [promiseForError, promiseForSeriesList, promiseForPersonList], timeout: 4)
    }
    
    func test_pass_getGlobalSearchOutputForSearchContext() {
        // MARK: Given
        let mockSUT = MockGlobalSearchDC()
        let searchContext = "Lost"
        let delegate = mockSUT.delegate as! MockGlobalSearchTVC
//        let delegateMethodWasCalled = expectation(for: NSPredicate(value: true), evaluatedWith: delegate.didUpdateTableViewCalled)
        // MARK: workable approach 1
//        let predicate = NSPredicate(format: "didUpdateTableViewCalled == true")
//        let delegateMethodWasCalled = expectation(for: predicate, evaluatedWith: delegate)
        // MARK: workable approach 2
        let predicateKVO = XCTKVOExpectation(keyPath: "didUpdateTableViewCalled", object: delegate, expectedValue: true)
        // MARK: When
        mockSUT.getGlobalSearchOutputFor(searchContext: searchContext)
        // MARK: Then
        wait(for: [predicateKVO], timeout: 5)
        XCTAssert(mockSUT.seriesList == [TestDataObject.seriesModel])
        XCTAssert(mockSUT.personList == [TestDataObject.personModel])
    }
    // MARK: doesn't work
    //        let predicate = NSPredicate(format: "%K == %@", #keyPath( delegate.didUpdateTableViewCalled), true)
    //        let delegateMethodWasCalled = expectation(for: NSPredicate(value: delegate.didUpdateTableViewCalled == true), evaluatedWith: delegate.didUpdateTableViewCalled)
    
    func test_fail_getGlobalSearchOutputForSearchContext() {
        // MARK: Given
        let mockSUT = MockGlobalSearchDC()
        let searchContext = "Lost_fail"
        let delegate = mockSUT.delegate as! MockGlobalSearchTVC
        let predicate = NSPredicate(format: "didUpdateTableViewCalled == false")
        let delegateMethodWasCalled = expectation(for: predicate, evaluatedWith: delegate)
        // MARK: When
        mockSUT.getGlobalSearchOutputFor(searchContext: searchContext)
        // MARK: Then
        wait(for: [delegateMethodWasCalled], timeout: 5)
        XCTAssertNil(mockSUT.seriesList)
        XCTAssertNil(mockSUT.personList)
    }
    //        let delegateMethodWasCalled = expectation(for: NSPredicate(value: false), evaluatedWith: delegate.didUpdateTableViewCalled)
    
    func test_break_getGlobalSearchOutputForSearchContext() {
        // TODO
    }
    
    func test_didEmptySearchResults() {
        // MARK: Given
        let mockSUT = MockGlobalSearchDC()
        let searchContext = "Lost"
        // MARK: When
        mockSUT.getGlobalSearchOutputFor(searchContext: searchContext)
        mockSUT.didEmptySearchResults()
        // MARK: Then
        XCTAssertNil(mockSUT.seriesList)
        XCTAssertNil(mockSUT.personList)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
