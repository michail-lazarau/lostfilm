import Foundation

protocol UserSessionService: AnyObject {
    var userInitials: String { get }
    var username: String { get set }
    var isAuthorised: Bool { get }
}
