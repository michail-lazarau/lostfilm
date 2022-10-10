import Foundation

final class LoginViewModel {
    typealias Username = String
    typealias Captcha = LFLoginPageModel
    private var captcha: Captcha?
    private let dataProvider: LoginServiceProtocol
    weak var delegate: LoginViewControllerDelegate?
    let htmlParserWrapper: DVHtmlToModels = DVHtmlToModels(contextByName: "GetLoginPageContext")

    init(dataProvider: LoginServiceProtocol) {
        self.dataProvider = dataProvider
    }

    // func signature: , response: @escaping (Result<Username, Error>) -> Void
    func login(eMail: String, password: String, captcha: String?) {
        delegate?.displayUIActivityIndicator() // MARK: main thread
        dataProvider.login(eMail: eMail, password: password, captcha: captcha) { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case let .success(username):
                strongSelf.captcha = nil
                strongSelf.delegate?.authorise(username: username)
            case let .failure(error):
                strongSelf.delegate?.showError(error: error)
            }

            strongSelf.delegate?.removeUIActivityIndicator()
        }
    }

    func checkLoginPageForCaptcha(completionForLogin: @escaping () -> Void) {
        delegate?.displayUIActivityIndicator() // MARK: main thread
        if !(captcha?.captchaIsRequired ?? false) {
            dataProvider.getLoginPage(htmlParserWrapper: htmlParserWrapper) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }

                switch result {
                case let .success(captcha):
                    if captcha.captchaIsRequired {
                        strongSelf.captcha = captcha // MARK: prevent calling captcha: captcha does not require updating once it's displayed
                        strongSelf.delegate?.updateCaptcha(url: captcha.captchaUrl)
                    } else {
                        completionForLogin()
                    }
                case let .failure(error):
                    strongSelf.delegate?.showError(error: error)
                }

                strongSelf.delegate?.removeUIActivityIndicator()
            }
        } else { // MARK: main thread
            delegate?.updateCaptcha(url: captcha!.captchaUrl) // MARK: captcha cannot be nil here. The function is evoked to prevent captcha staleness over time.
            delegate?.removeUIActivityIndicator()
            completionForLogin()
        }
    }
    // FIXME: "'mutating' is not valid on instance methods in classes" error occurs when the capture list [captchaIsMandatory, delegate] is used
}
