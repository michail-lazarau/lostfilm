//
//  ProfileViewModelDelegateMock.swift
//  lostfilmTests
//
//  Created by u.yanouski on 2022-12-27.
//

import Foundation
import XCTest
@testable import lostfilm

final class ProfileViewModelDelegateMock: ProfileViewProtocol {
    var buttonStatus: ((Bool) -> Void)?
    var didCallNameConformationMessage: ((String) -> Void)?
    var didCallSurnameConformationMessage: ((String) -> Void)?
    var didCallNameErrorMessage: ((String) -> Void)?
    var didCallSurnameErrorMessage: ((String) -> Void)?
    
    func setButtonEnabled(_ isEnable: Bool) {
        buttonStatus?(isEnable)
    }

    func sendNameConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        didCallNameConformationMessage?(confirmationMessage)
    }

    func sendSurnameConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        didCallSurnameConformationMessage?(confirmationMessage)
    }

    func sendNameErrorMessage(_ errorMessage: String, color: UIColor) {
        didCallNameErrorMessage?(errorMessage)
    }

    func sendSurnameErrorMessage(_ errorMessage: String, color: UIColor) {
        didCallSurnameErrorMessage?(errorMessage)
    }
}
