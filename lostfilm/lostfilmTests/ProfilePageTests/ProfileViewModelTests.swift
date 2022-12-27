//
//  ProfileViewModelTests.swift
//  lostfilmTests
//
//  Created by u.yanouski on 2022-12-27.
//

@testable import lostfilm
import XCTest

final class ProfileViewModelTests: XCTestCase {

    var sut: ProfileViewModel!
    var delegate: ProfileViewModelDelegateMock!

    override func setUpWithError() throws {
        sut = ProfileViewModel(countryService: MockCountyService(), debouncer: MockDebouncer())
        delegate = ProfileViewModelDelegateMock()
        sut.view = delegate
    }

    override func tearDownWithError() throws {
        sut = nil
        delegate = nil
    }

    func test_SendNameConfirmationMessage() {
        let sendNameConformationMessage = XCTestExpectation(description: "sendNameConformationMessage() expectation")
        delegate.didCallNameConformationMessage = { message in
            XCTAssertEqual(message, ValidationConfirmation.validName)
            sendNameConformationMessage.fulfill()
        }
        sut.didEnterNameTextFieldWithString(nameViewString: "Name")
        wait(for: [sendNameConformationMessage], timeout: 0)
    }

    func test_SendNameErrorMessage() {
        let sendEmailErrorMessage = XCTestExpectation(description: "sendEmailErrorMessage() expectation" )
        delegate.didCallNameErrorMessage = { message in
            XCTAssertEqual(message, ValidationErrors.invalidName)
            sendEmailErrorMessage.fulfill()
        }
        sut.didEnterNameTextFieldWithString(nameViewString: "inv")
        wait(for: [sendEmailErrorMessage], timeout: 0)
    }

    func test_SendSurnameConformationMessage() {
        let sendSurnameConformationMessage = XCTestExpectation(description: "sendSurnameConformationMessage expectation")
        delegate.didCallSurnameConformationMessage = { message in
            XCTAssertEqual(message, ValidationConfirmation.validSurname)
            sendSurnameConformationMessage.fulfill()
        }
        sut.didEnterSurnameTextFieldWithString(surnameViewString: "Surname")
        wait(for: [sendSurnameConformationMessage], timeout: 0)
    }

    func test_SendSurnameErrorMessage() {
        let sendSurnameErrorMessage = XCTestExpectation(description: "sendSurnameErrorMessage expectation")
        delegate.didCallSurnameErrorMessage = { message in
            XCTAssertEqual(message, ValidationErrors.invalidSurname)
            sendSurnameErrorMessage.fulfill()
        }
        sut.didEnterSurnameTextFieldWithString(surnameViewString: "inv")
        wait(for: [sendSurnameErrorMessage], timeout: 0)
    }
}
