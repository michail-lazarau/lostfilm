import Foundation

class UserSessionService {
    static var username: String? {
        return UserDefaults.standard.object(forKey: "lf_username") as? String
    }

    static func authorised() -> Bool {
        guard let url = URL(string: "https://www.lostfilm.tv"), let cookies = HTTPCookieStorage.shared.cookies(for: url) else {
            return false
        }
        HTTPCookieStorage.shared.cookies
        return cookies.contains { $0.name == "lf_session" }
    }
}
