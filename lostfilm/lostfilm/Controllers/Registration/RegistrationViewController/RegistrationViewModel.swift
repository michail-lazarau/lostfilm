//
//  RegistrationViewModel.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-05.
//

import Foundation

protocol RegistrationViewModelProtocol: AnyObject {
    func checkButtonStatus(nicknameViewString: String, emailViewString: String, passwordViewString: String, repeatPasswordViewString: String, isCaptchaButtonSelected: Bool)
    func didEnterNicknameTextFieldWithString(nicknameViewString: String)
    func didEnterEmailTextFieldWithString(emailViewString: String)
    func didEnterPasswordTextFieldWithString(passwordViewString: String)
    func didEnterRepeatPasswordTextFieldWithString(repeatPasswordViewString: String, passwordViewString: String)
    func viewReady(_ view: RegistrationViewProtocol)
    func readyButtonAction()
}

final class RegistrationViewModel {
    // MARK: Variables
    weak var view: RegistrationViewProtocol?
    private let debouncer: DebouncerProtocol
    private let router: RegistrationRouterProtocol

    // MARK: Inits
    init(debouncer: DebouncerProtocol, router: RegistrationRouterProtocol) {
        self.debouncer = debouncer
        self.router = router
    }
}

extension RegistrationViewModel: RegistrationViewModelProtocol {

    func viewReady(_ view: RegistrationViewProtocol) {
        self.view = view
    }

    func readyButtonAction() {
        router.openRegistrationViewController()
    }

    func checkButtonStatus(nicknameViewString: String, emailViewString: String, passwordViewString: String, repeatPasswordViewString: String, isCaptchaButtonSelected: Bool) {
        if  Validators.nickname.validate(nicknameViewString)  &&
            Validators.email.validate(emailViewString) &&
            Validators.password.validate(passwordViewString) &&
            Validators.password.validate(repeatPasswordViewString) && passwordViewString == repeatPasswordViewString &&
            isCaptchaButtonSelected == true {
            view?.setButtonEnabled(true)
        } else {
            view?.setButtonEnabled(false)
        }
    }

    func didEnterNicknameTextFieldWithString(nicknameViewString: String) {
        debouncer.debounce { [weak self] in
            if Validators.nickname.validate(nicknameViewString) {
                self?.view?.sendNicknameConformationMessage(ValidationConfirmation.validNickname, color: .green) // true test выполняется  sendNicknameConformationMessage
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
