import Foundation

protocol DataControllerDelegate: AnyObject {
    func updateUIForTableWith(rowsRange: Range<Int>)
    func showSignedInUserProfileButton(with userInitials: String)
    func showSignedOutProfileButton()
}
