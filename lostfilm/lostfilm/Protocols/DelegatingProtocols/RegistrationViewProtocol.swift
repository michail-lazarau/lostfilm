//
//  RegistrationViewProtocol.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-04.
//

import Foundation

protocol RegistrationViewProtocol: AnyObject {
    func setButtonEnabled(_ isEnable: Bool)
    func sendNicknameConformationMessage(_ confirmationMessage: String, color: UIColor)
    func sendEmailConfirmationMessage(_ confirmationMessage: String, color: UIColor)
    func sendPasswordConfirmationMessage(_ confirmationMessage: String, color: UIColor)
    func sendRepeatPasswordConfirmationMessage(_ confirmationMessage: String, color: UIColor)
    func sendNicknameErrorMessage(_ errorMessage: String, color: UIColor)
    func sendEmailErrorMessage(_ errorMessage: String, color: UIColor)
    func sendPasswordErrorMessage(_ errorMessage: String, color: UIColor)
    func sendRepeatPasswordErrorMessage(_ errorMessage: String, color: UIColor)
}
