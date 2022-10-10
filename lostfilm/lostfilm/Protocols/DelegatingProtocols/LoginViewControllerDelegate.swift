import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func showError(error: Error)
    func authorise(username: String)
    func updateCaptcha(url: URL)
    func displayUIActivityIndicator()
    func removeUIActivityIndicator()
}
