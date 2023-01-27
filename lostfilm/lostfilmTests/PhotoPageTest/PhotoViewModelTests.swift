//
//  PhotoPageTest.swift
//  lostfilmTests
//
//  Created by u.yanouski on 2023-01-27.
//

@testable import lostfilm
import XCTest

final class PhotoViewModelTest: XCTestCase {

    var sut: PhotoViewModel!
    var router: MockRegistrationRouter!

    override func setUpWithError() throws {
        router = MockRegistrationRouter()
        sut = PhotoViewModel(router: router)
    }

    override func tearDownWithError() throws {
        sut = nil
        router = nil
    }

    func test_doneButtonAction() {
        sut.doneButtonAction()
        wait(for: [router.showCallFuncCloseControllerExpectation], timeout: 0)
    }
}
