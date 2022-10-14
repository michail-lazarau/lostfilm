import Foundation

protocol LoginViewProtocol: AnyObject {
    func showError(error: Error)
    func authorise(username: String)
//    func updateCaptcha(url: URL) // TODO: delete
    func prepareCaptchaToDisplay()
    func updateCaptcha(data: Data)
    func displayLoadingIndicator()
    func removeLoadingIndicator()
}
