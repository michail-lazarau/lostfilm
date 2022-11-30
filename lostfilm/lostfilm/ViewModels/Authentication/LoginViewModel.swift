import Foundation

protocol LoginViewModelProtocol: AnyObject {
    func checkButtonStatus(emailViewString: String, passwordViewString: String, captchaViewString: String?, isCaptchaHidden: Bool)
    func didEnterEmailTextFieldWithString(emailViewString: String)
    func didEnterPasswordTextFieldWithString(passwordViewString: String)
}

final class LoginViewModel {
    typealias Captcha = LFLoginPageModel
    typealias Routes = Dismissable
    private let router: Routes
    private(set) var captchaModel: Captcha?
    weak var view: LoginViewProtocol?
    let htmlParserWrapper: DVHtmlToModels = DVHtmlToModels(contextByName: "GetLoginPageContext")
    let dataProvider: LoginServiceProtocol
    private let debouncer: DebouncerProtocol

    init(dataProvider: LoginServiceProtocol, router: Routes, debouncer: DebouncerProtocol) {
        self.dataProvider = dataProvider
        self.router = router
        self.debouncer = debouncer
    }

    func login(email: String, password: String, captcha: String?) {
        if !(captchaModel?.captchaIsRequired ?? false) {
            checkForCaptcha(htmlParserWrapper: htmlParserWrapper, email: email, password: password, captcha: captcha)
        } else {
            authenticate(email: email, password: password, captcha: captcha)
        }
    }

    func dismissLoginScreen() {
        router.dismiss()
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
        } else {
            if !emailViewString.isEmpty && !passwordViewString.isEmpty &&  Validators.email.validate(emailViewString) && Validators.password.validate(passwordViewString) && !(captchaViewString?.isEmpty ?? true) {
                view?.setButtonEnabled(true)
            } else {
                view?.setButtonEnabled(false)
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
