import Foundation

protocol DataControllerDelegate: AnyObject {
    func updateUIForTableWith(rowsRange: Range<Int>)
    func showProfileButton(with username: String)
    func showSignedOutProfileButton()
}
