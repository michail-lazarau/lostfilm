//
//  RegistrationViewModelTests.swift
//  lostfilmTests
//
//  Created by u.yanouski on 2022-12-13.
//
@testable import lostfilm
import XCTest

class RegistrationViewModelTest: XCTestCase {

    var sut: RegistrationViewModel! // объект вью модели  (ссылки)
    var delegate: RegistrationViewModelDelegateMock! // "обьект"  RegistrationViewModelDelegateMock (ссылка/ указатель на объкт этого класса ) мы меняет реализацию протокола из класса RegistrationViewModel!  с RegistrationViewProtocol на моконовый  RegistrationViewModelDelegateMock!

    override func setUpWithError() throws {
        sut = RegistrationViewModel(debouncer: MockDebouncer()) // инитим 
        delegate = RegistrationViewModelDelegateMock() // инитим
        sut.view = delegate // вью как проперти класса RegistrationViewModel! на которой выпоняется фунция теста (didEnterNicknameTextFieldWithString)  и вью реализует   RegistrationViewProtocol?
    }

    override func tearDownWithError() throws {
        sut = nil
        delegate = nil
    }

    func test_SendNicknameConfirmationMessage() {
        let sendNicknameConformationMessage = XCTestExpectation(description: "sendNicknameConfirmationMessage() expectation")
        delegate.didCallNicknameConfirmationMessage = { message in
            XCTAssertEqual(message, ValidationConfirmation.validNickname)
            sendNicknameConformationMessage.fulfill()
        }
        sut.didEnterNicknameTextFieldWithString(nicknameViewString: "Name") // выполняем функцию на вью модели 
        wait(for: [sendNicknameConformationMessage], timeout: 0)
    }

    func test_SendNicknameErrorMessage() {
        let sendNicknameConfirmationMessage = XCTestExpectation(description: "test_SendNicknameErrorMessage() expectation")
        delegate.didCallNicknameErrorMessage = { message in
            XCTAssertEqual(message, ValidationError.invalidNickname.localizedDescription)
            sendNicknameConfirmationMessage.fulfill()
        }
        sut.didEnterNicknameTextFieldWithString(nicknameViewString: "n")
        wait(for: [sendNicknameConfirmationMessage], timeout: 0)
    }

    func test_SendEmailConfirmationMessage() {
        let sendEmailConfirmationMessage = XCTestExpectation(description: "sendEmailConfirmationMessage() expectation")
        delegate.didCallEmailConfirmationMessage = { message in
            XCTAssertEqual(message, ValidationConfirmation.validEmail)
            sendEmailConfirmationMessage.fulfill()
        }
        sut.didEnterEmailTextFieldWithString(emailViewString: "Valid@gmail.com")
        wait(for: [sendEmailConfirmationMessage], timeout: 0)
    }

   func test_SendEmailErrorMessage() {
       let sendEmailErrorMessage = XCTestExpectation(description: "sendEmailErrorMessage() expectation")
       delegate.didCallEmailErrorMessage = { message in
           XCTAssertEqual(message, ValidationError.invalidEmail.localizedDescription)
           sendEmailErrorMessage.fulfill()
       }
       sut.didEnterEmailTextFieldWithString(emailViewString: "invalidEmail")
       wait(for: [sendEmailErrorMessage], timeout: 0)
    }

    func test_SendPasswordConfirmationMessage() {
        let sendPasswordConfirmationMessage = XCTestExpectation(description: "sendPasswordConfirmationMessage() expectation")
        delegate.didCallPasswordConfirmationMessage = { message  in
            XCTAssertEqual(message, ValidationConfirmation.validPassword)
            sendPasswordConfirmationMessage.fulfill()
        }
        sut.didEnterPasswordTextFieldWithString(passwordViewString: "Asap123")
        wait(for: [sendPasswordConfirmationMessage], timeout: 0)
    }

    func test_SendPasswordErrorMessage() {
        let sendPasswordErrorMessage = XCTestExpectation(description: "sendPasswordErrorMessage() expectation")
        delegate.didCallPasswordErrorMessage = { message in
            XCTAssertEqual(message, ValidationError.invalidPassword.localizedDescription)
            sendPasswordErrorMessage.fulfill()
        }
        sut.didEnterPasswordTextFieldWithString(passwordViewString: "invalidePassword")
        wait(for: [sendPasswordErrorMessage], timeout: 0)
    }

    func test_SendRepeatPasswordConfirmationMessage() {
        let sendRepeatPasswordConfirmationMessage = XCTestExpectation(description: "sendRepeatPasswordConfirmationMessage() expectation")
        delegate.didCallRepeatPasswordConfirmationMessage = { message in
            XCTAssertEqual(message, ValidationConfirmation.validPassword)
            sendRepeatPasswordConfirmationMessage.fulfill()
        }
        sut.didEnterRepeatPasswordTextFieldWithString(repeatPasswordViewString: "Asap123", passwordViewString: "Asap123")
        wait(for: [sendRepeatPasswordConfirmationMessage], timeout: 0)
    }

    func test_SendRepeatPasswordErrorMessageWithInvalidPasswordString() {
        let sendRepeatPasswordErrorMessage = XCTestExpectation(description: "sendRepeatPasswordErrorMessage expectation")
        delegate.didCallRepeatPasswordErrorMessage = {message in
            XCTAssertEqual(message, ValidationError.invalidPassword.localizedDescription)
            sendRepeatPasswordErrorMessage.fulfill()
        }
        sut.didEnterRepeatPasswordTextFieldWithString(repeatPasswordViewString: "invalid", passwordViewString: "Asap123")
        wait(for: [sendRepeatPasswordErrorMessage], timeout: 0)
    }

    func test_SendRepeatPasswordErrorMessageWithStringWithInvalidRepeatPasswordString() {
        let sendRepeatPasswordErrorMessageWithoutString = XCTestExpectation(description: "sendRepeatPasswordErrorMessageWithoutString() expectation")
        delegate.didCallRepeatPasswordErrorMessage = { message in
            XCTAssertEqual(message, ValidationError.invalidPassword.localizedDescription)
        }
        sut.didEnterRepeatPasswordTextFieldWithString(repeatPasswordViewString: "invalid", passwordViewString: "Asap123")
        wait(for: [sendRepeatPasswordErrorMessageWithoutString], timeout: 0)
    }

    func test_SendRepeatPasswordErrorMessageWithoutPasswordString() {
        let sendRepeatPasswordErrorMessageWithoutPasswordString = XCTestExpectation(description: "sendRepeatPasswordErrorMessageWithoutPasswordString() expectation")
        delegate.didCallRepeatPasswordErrorMessage = { message in
            XCTAssertEqual(message, ValidationError.invalidPassword.localizedDescription)
            sendRepeatPasswordErrorMessageWithoutPasswordString.fulfill()
        }
        sut.didEnterRepeatPasswordTextFieldWithString(repeatPasswordViewString: "Asap123", passwordViewString: "")
        wait(for: [sendRepeatPasswordErrorMessageWithoutPasswordString], timeout: 0)
    }
}
