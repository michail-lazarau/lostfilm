import Foundation

protocol LoginViewModelProtocol: AnyObject {
    func checkButtonStatus(emailViewString: String, passwordViewString: String, captchaViewString: String?, isCaptchaHidden: Bool)
}

  final class LoginViewModel {
    typealias Captcha = LFLoginPageModel
    private(set) var captchaModel: Captcha?
    weak var view: LoginViewProtocol?
    let htmlParserWrapper: DVHtmlToModels = DVHtmlToModels(contextByName: "GetLoginPageContext")
    let dataProvider: LoginServiceProtocol

    init(dataProvider: LoginServiceProtocol) {
        self.dataProvider = dataProvider
    }

    func login(email: String, password: String, captcha: String?) {
        if !(captchaModel?.captchaIsRequired ?? false) {
            checkForCaptcha(htmlParserWrapper: htmlParserWrapper, email: email, password: password, captcha: captcha)
        } else {
            authenticate(email: email, password: password, captcha: captcha)
        }
    }
}

extension LoginViewModel: LoginViewModelProtocol {

    func checkButtonStatus(emailViewString: String, passwordViewString: String, captchaViewString: String?, isCaptchaHidden: Bool) {
        if isCaptchaHidden {
            if !emailViewString.isEmpty && !passwordViewString.isEmpty && Validators.email.validate(emailViewString) && Validators.password.validate(passwordViewString) {
                view?.setButtonEnabled(true)
            } else {
                view?.setButtonEnabled(false)
            }
        } else if let  captchaString = captchaViewString {
            if !emailViewString.isEmpty && !passwordViewString.isEmpty && !captchaString.isEmpty && Validators.email.validate(emailViewString) && Validators.password.validate(passwordViewString) {
                view?.setButtonEnabled(true)
            } else {
                view?.setButtonEnabled(false)
            }
        }
      }

      func didEnterEmailTextFieldWithString(emailViewString: String) {
          if Validators.email.validate(emailViewString) {
            view?.sendEmailConfirmationMessage(ValidationConfirmation.validEmail, color: .green)
             return
          } else {
              view?.sendEmailErrorMessage(ValidationError.invalidEmail.localizedDescription, color: .red)
          }
      }

    func didEnterPasswordTextFieldWithString(passwordViewString: String) {
        if Validators.password.validate(passwordViewString) {
            view?.sendPasswordConfirmationMessage(ValidationConfirmation.validPassword, color: .green)
        } else {
            view?.sendPasswordErrorMessage(ValidationError.invalidPassword.localizedDescription, color: .red)
        }
    }

    func checkForCaptcha(htmlParserWrapper: DVHtmlToModels, email: String, password: String, captcha: String?) {
        dataProvider.getLoginPage(htmlParserWrapper: htmlParserWrapper) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case let .success(captchaModel):
                self.captchaModel = captchaModel
                if captchaModel.captchaIsRequired {
                    self.renderCaptcha(url: captchaModel.captchaUrl)
                } else {
                    self.authenticate(email: email, password: password, captcha: captcha)
                }
            case let .failure(error):
                self.view?.removeLoadingIndicator()
                self.view?.showError(error: error)
            }
        }
    }

    func renderCaptcha(url: URL) {
        view?.prepareCaptchaToUpdate()
        dataProvider.getCaptcha(url: url) { [view] result in
            switch result {
            case let .success(data):
                view?.updateCaptcha(data: data)
                view?.setButtonEnabled(false)
            case let .failure(error):
                view?.hideCaptchaWhenFailedToLoad()
                view?.showError(error: error)
            }
            view?.removeLoadingIndicator()
        }
    }

    func authenticate(email: String, password: String, captcha: String?) {
        dataProvider.login(email: email, password: password, captcha: captcha) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case let .success(username):
                self.captchaModel = nil
                self.view?.removeLoadingIndicator()
                self.view?.authorise(username: username)
            case let .failure(error):
                defer {
                    self.view?.removeLoadingIndicator()
                    self.view?.showError(error: error)
                }

                let loginServiceError = error as? LoginServiceError
                if loginServiceError == .invalidCaptcha || loginServiceError == .needCaptcha {
                    guard let captchaUrl = self.captchaModel?.captchaUrl, let randomQueryCaptcha = URL(string: "?\(Double.random(in: 0 ..< 1))", relativeTo: captchaUrl) else {
                        return
                    }
                    self.renderCaptcha(url: randomQueryCaptcha)
                }
            }
        }
    }
}
