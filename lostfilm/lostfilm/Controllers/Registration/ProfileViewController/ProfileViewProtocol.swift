//
//  ProfileViewProtocol.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-22.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
    func setButtonEnabled(_ isEnable: Bool)
    func sendNameConfirmationMessage(_ confirmationMessage: String, color: UIColor)
    func sendSurnameConfirmationMessage(_ confirmationMessage: String, color: UIColor)
    func sendNameErrorMessage(_ errorMessage: String, color: UIColor)
    func sendSurnameErrorMessage(_ errorMessage: String, color: UIColor)
}
