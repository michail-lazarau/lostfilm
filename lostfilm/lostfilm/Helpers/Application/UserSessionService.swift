import Foundation

protocol UserSessionService: AnyObject {
    var username: String? { get set }
    func isAuthorised() -> Bool
}

class UserSessionStoredData: UserSessionService {
    private var _username: String?
    var username: String? {
        get {
            let name = _username ?? UserDefaults.standard.object(forKey: UserProperties.username.rawValue) as? String
            let title = name?.split { $0 == " " }.reduce(into: String()) { partialResult, substring in
                partialResult.append(substring.first?.uppercased() ?? "?")
            }
            return title
        }
        set {
            _username = newValue
            saveToUserDefaults(key: .username, value: newValue)
        }
    }

    func isAuthorised() -> Bool {
        guard let url = URL(string: "https://www.lostfilm.tv"), let cookies = HTTPCookieStorage.shared.cookies(for: url) else {
            return false
        }
        return cookies.contains { $0.name == SessionProperties.session.rawValue }
    }

    private func saveToUserDefaults(key: UserProperties, value: Any?) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
}

private enum UserProperties: String {
    case username = "lf_username"
}

private enum SessionProperties: String {
case session = "lf_session"
}
