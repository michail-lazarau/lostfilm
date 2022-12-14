//
//  RegistrationViewModelDelegateMock.swift
//  lostfilmTests
//
//  Created by u.yanouski on 2022-12-13.
//

import Foundation
import XCTest
@testable import lostfilm

final class RegistrationViewModelDelegateMock: RegistrationViewProtocol {

    var didCallNicknameConfirmationMessage: ((String) -> Void)?
    var didCallNicknameErrorMessage: ((String) -> Void)?
    var didCallEmailConfirmationMessage: ((String) -> Void)?
    var didCallEmailErrorMessage: ((String) -> Void)?
    var didCallPasswordConfirmationMessage: ((String) -> Void)?
    var didCallPasswordErrorMessage: ((String) -> Void)?
    var didCallRepeatPasswordConfirmationMessage: ((String) -> Void)?
    var didCallRepeatPasswordErrorMessage: ((String) -> Void)?
    var buttonStatus: ((Bool) -> Void)?

    func setButtonEnabled(_ isEnable: Bool) {
        buttonStatus?(isEnable)
    }

    func sendNicknameConformationMessage(_ confirmationMessage: String, color: UIColor) {
        didCallNicknameConfirmationMessage?(confirmationMessage) // выполнятся в registrationViewModelTests тк там присвои {}
    }

    func sendEmailConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        didCallEmailConfirmationMessage?(confirmationMessage)
    }

    func sendPasswordConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        didCallPasswordConfirmationMessage?(confirmationMessage)
    }

    func sendRepeatPasswordConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        didCallRepeatPasswordConfirmationMessage?(confirmationMessage)
    }

    func sendNicknameErrorMessage(_ errorMessage: String, color: UIColor) {
       didCallNicknameErrorMessage?(errorMessage)
    }

    func sendEmailErrorMessage(_ errorMessage: String, color: UIColor) {
        didCallEmailErrorMessage?(errorMessage)
    }

    func sendPasswordErrorMessage(_ errorMessage: String, color: UIColor) {
        didCallPasswordErrorMessage?(errorMessage)
    }

    func sendRepeatPasswordErrorMessage(_ errorMessage: String, color: UIColor) {
       didCallRepeatPasswordErrorMessage?(errorMessage)
    }
}
