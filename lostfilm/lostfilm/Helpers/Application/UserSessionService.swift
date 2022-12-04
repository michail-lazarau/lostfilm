import Foundation

protocol UserSessionService {
    var username: String? { get }
    func authorised() -> Bool
    func willSaveToUserDefaults(key: UserProperties, value: Any?)
}

class UserSessionInfo: UserSessionService {
    var username: String? {
        return UserDefaults.standard.object(forKey: UserProperties.username.rawValue) as? String
    }

    func authorised() -> Bool {
        guard let url = URL(string: "https://www.lostfilm.tv"), let cookies = HTTPCookieStorage.shared.cookies(for: url) else {
            return false
        }
        return cookies.contains { $0.name == UserProperties.session.rawValue }
    }

    func willSaveToUserDefaults(key: UserProperties, value: Any?) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
}

enum UserProperties: String {
    case username = "lf_username"
    case session = "lf_session"
}
