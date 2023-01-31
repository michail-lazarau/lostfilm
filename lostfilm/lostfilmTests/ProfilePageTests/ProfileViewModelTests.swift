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
    var router: MockRegistrationRouter!

    override func setUpWithError() throws {
        router = MockRegistrationRouter()
        sut = ProfileViewModel(countryService: MockCountyService(), debouncer: MockDebouncer(), router: router)
        delegate = ProfileViewModelDelegateMock()
        sut.view = delegate
    }

    override func tearDownWithError() throws {
        sut = nil
        delegate = nil
        router = nil
    }

    // MARK: sendMessage Functionality
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

    // MARK: Button isEnbaled
    func test_nextButtonEnable() {
        let buttonExpectation = XCTestExpectation(description: "buttonExpectation")
        delegate.buttonStatus = { isEnable in
            XCTAssertTrue(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(nameViewString: "Name", surnameViewString: "Surname", countyPickerString: "Japan", cityPickerString: "Tokio")
        wait(for: [buttonExpectation], timeout: 0)
    }

    // MARK: Button isDisabled
    func test_isNextButtonDisabledNameTextFieldIsEmpty() {
        let buttonExpectation = XCTestExpectation(description: "buttonExpectation")
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(nameViewString: "", surnameViewString: "Surname", countyPickerString: "Japan", cityPickerString: "Tokio")
        wait(for: [buttonExpectation], timeout: 0)
    }

    func test_isNextButtonDisabledSurnameTextFieldIsEmpty() {
        let buttonExpectation = XCTestExpectation(description: "buttonExpectation")
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(nameViewString: "Name", surnameViewString: "", countyPickerString: "Japan", cityPickerString: "Tokio")
        wait(for: [buttonExpectation], timeout: 0)
    }

    func test_isNextButtonDisabledCountryStringTextFieldIsEmpty() {
        let buttonExpectation = XCTestExpectation(description: "buttonExpectation")
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(nameViewString: "Name", surnameViewString: "Surname", countyPickerString: "", cityPickerString: "Tokio")
        wait(for: [buttonExpectation], timeout: 0)
    }

    func test_isNextButtonDisabledCityStringTextFieldIsEmpty() {
        let buttonExpectation = XCTestExpectation(description: "buttonExpectation")
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(nameViewString: "Name", surnameViewString: "Surname", countyPickerString: "Japan", cityPickerString: "")
        wait(for: [buttonExpectation], timeout: 0)
    }

    func test_isNextButtonDisabledAllTextFieldIsEmpty() {
        let buttonExpectation = XCTestExpectation(description: "buttonExpectation")
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(nameViewString: "", surnameViewString: "", countyPickerString: "", cityPickerString: "")
        wait(for: [buttonExpectation], timeout: 0)
    }

    func test_isNextButtonDisabledWithInvalidNameStringTextField() {
        let buttonExpectation = XCTestExpectation(description: "buttonExpectation")
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(nameViewString: "inv", surnameViewString: "Surname", countyPickerString: "Japan", cityPickerString: "Tokio")
        wait(for: [buttonExpectation], timeout: 0)
    }

    func test_isNextButtonDisabledWithInvalidSurnameStringTextField() {
        let buttonExpectation = XCTestExpectation(description: "buttonExpectation")
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(nameViewString: "Name", surnameViewString: "inv", countyPickerString: "Japan", cityPickerString: "Tokio")
        wait(for: [buttonExpectation], timeout: 0)
    }

    func test_NextButtonAction() {
        sut.nextButtonAction()
        wait(for: [router.showCallFuncOpenPhotoViewControllerExpectation], timeout: 0)
    }
}
