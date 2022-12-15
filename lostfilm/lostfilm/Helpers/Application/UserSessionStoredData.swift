import Foundation
import KeychainAccess

class UserSessionStoredData: UserSessionService {
    private let httpCookieStorage: HTTPCookieStorageable
    private let sensitiveDataStorage: Keychainable
    private let domainUrl: URL?

    var username: String {
        get {
            guard let username = try? sensitiveDataStorage.get(UserProperties.username.rawValue, ignoringAttributeSynchronizable: true) else {
                return "?"
            }
            let trimmed = username.trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed != "" ? trimmed : "?"
        }
        set {
            try? sensitiveDataStorage.set(newValue, key: UserProperties.username.rawValue, ignoringAttributeSynchronizable: true)
        }
    }

    var userInitials: String {
        return username.split { $0 == " " }.reduce(into: String()) { partialResult, substring in
            partialResult.append(substring.first?.uppercased() ?? "?")
        }
    }

    var isAuthorised: Bool {
        guard let url = domainUrl, let cookies = httpCookieStorage.cookies(for: url) else {
            return false
        }
        return cookies.contains { $0.name == SessionProperties.session.rawValue }
    }

    init(sensitiveDataStorage: Keychainable = Keychain(service: "com.personal.lostfilm"),
         httpCookieStorage: HTTPCookieStorageable = HTTPCookieStorage.shared,
         domainUrlForCookies: URL? = URL(string: "https://www.lostfilm.tv")) {
        self.sensitiveDataStorage = sensitiveDataStorage
        self.httpCookieStorage = httpCookieStorage
        domainUrl = domainUrlForCookies
    }
}

enum UserProperties: String {
    case username = "lf_username"
}

enum SessionProperties: String {
    case session = "lf_session"
}
