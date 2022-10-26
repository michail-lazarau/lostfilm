import Foundation

protocol LoginViewProtocol: AnyObject {
    func showError(error: Error)
    func authorise(username: String)
    func updateCaptcha(data: Data)
    func removeLoadingIndicator()
    func prepareCaptchaToDisplay()
}
