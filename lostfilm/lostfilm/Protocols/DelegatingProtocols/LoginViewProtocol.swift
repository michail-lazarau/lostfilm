import Foundation

protocol LoginViewProtocol: AnyObject {
    func showError(error: Error)
    func authorise(username: String)
    func removeLoadingIndicator()
    func prepareCaptchaToUpdate()
    func updateCaptcha(data: Data)
    func hideCaptchaWhenFailedToLoad()
    func setButtonEnabled(_ isEnable: Bool)
    func sendEmailConfirmationMessage(_ confirmationMessage: String, color: UIColor)
    func sendPasswordConfirmationMessage(_ confirmationMessage: String, color: UIColor)
    func sendEmailErrorMessage(_ errorMessage: String, color: UIColor)
    func sendPasswordErrorMessage(_ errorMessage: String, color: UIColor)
}
