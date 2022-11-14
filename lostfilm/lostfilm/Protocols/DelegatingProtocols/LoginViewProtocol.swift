import Foundation

protocol LoginViewProtocol: AnyObject {
    func showError(error: Error)
    func authorise(username: String)
    func removeLoadingIndicator()
    func prepareCaptchaToUpdate()
    func updateCaptcha(data: Data)
    func hideCaptchaWhenFailedToLoad()
    func setButtonEnabled(_ isEnable: Bool)
    func sendErrorMessage(_ errorMessage: String)
}
