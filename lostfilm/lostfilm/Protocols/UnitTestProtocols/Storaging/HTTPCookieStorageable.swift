import Foundation

protocol HTTPCookieStorageable {
    func cookies(for URL: URL) -> [HTTPCookie]?
}

extension HTTPCookieStorage: HTTPCookieStorageable { }
