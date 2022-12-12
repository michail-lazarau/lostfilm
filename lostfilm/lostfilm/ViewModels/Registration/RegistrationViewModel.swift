//
//  RegistrationViewModel.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-05.
//

import Foundation

protocol RegistrationViewModelProtocol: AnyObject {
    func checkButtonStatus(nicknameViewString: String, emailViewString: String, passwordViewString: String, repeatPasswordViewString: String, isRememberMeButtonSelected: Bool)
    func didEnterNicknameTextFieldWithString(nicknameViewString: String)
    func didEnterEmailTextFieldWithString(emailViewString: String)
    func didEnterPasswordTextFieldWithString(passwordViewString: String)
    func didEnterRepeatPasswordTextFieldWithString(repeatPasswordViewString: String, passwordViewString: String)
}

final class RegistrationViewModel {
    // MARK: Variables
    weak var view: RegistrationViewProtocol?
    private let debouncer: DebouncerProtocol

    // MARK: Inits
    init(debouncer: DebouncerProtocol) {
        self.debouncer = debouncer
    }
}

extension RegistrationViewModel: RegistrationViewModelProtocol {
    func checkButtonStatus(nicknameViewString: String, emailViewString: String, passwordViewString: String, repeatPasswordViewString: String, isRememberMeButtonSelected: Bool) {
        if !nicknameViewString.isEmpty && Validators.nickname.validate(nicknameViewString)  &&
            !emailViewString.isEmpty && Validators.email.validate(emailViewString) &&
            !passwordViewString.isEmpty && Validators.password.validate(passwordViewString) &&
            !repeatPasswordViewString.isEmpty && Validators.password.validate(repeatPasswordViewString) && passwordViewString == repeatPasswordViewString &&
            !isRememberMeButtonSelected == false {
            view?.setButtonEnabled(true)
        } else {
            view?.setButtonEnabled(false)
        }
    }

    func didEnterNicknameTextFieldWithString(nicknameViewString: String) {
        debouncer.debounce { [weak self] in
            if Validators.nickname.validate(nicknameViewString) {
                self?.view?.sendNicknameConformationMessage(ValidationConfirmation.validNickname, color: .green)
            } else {
                self?.view?.sendNicknameErrorMessage(ValidationError.invalidNickname.localizedDescription, color: .red)
            }
        }
    }

    func didEnterEmailTextFieldWithString(emailViewString: String) {
        debouncer.debounce { [weak self] in
            if Validators.email.validate(emailViewString) {
                self?.view?.sendEmailConfirmationMessage(ValidationConfirmation.validEmail, color: .green)
            } else {
                self?.view?.sendEmailErrorMessage(ValidationError.invalidEmail.localizedDescription, color: .red)
            }
        }
    }

    func didEnterPasswordTextFieldWithString(passwordViewString: String) {
        debouncer.debounce { [weak self] in
            if Validators.password.validate(passwordViewString) {
                self?.view?.sendPasswordConfirmationMessage(ValidationConfirmation.validPassword, color: .green)
            } else {
                self?.view?.sendPasswordErrorMessage(ValidationError.invalidPassword.localizedDescription, color: .red)
            }
        }
    }

    func didEnterRepeatPasswordTextFieldWithString(repeatPasswordViewString: String, passwordViewString: String) {
        debouncer.debounce { [weak self] in
            if Validators.password.validate(repeatPasswordViewString) && repeatPasswordViewString == passwordViewString {
                self?.view?.sendRepeatPasswordConfirmationMessage(ValidationConfirmation.validPassword, color: .green)
            } else {
                self?.view?.sendRepeatPasswordErrorMessage(ValidationError.invalidPassword.localizedDescription, color: .red)
            }
        }
    }
}
