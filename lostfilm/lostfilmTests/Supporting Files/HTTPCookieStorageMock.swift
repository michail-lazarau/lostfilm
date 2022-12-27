import Foundation
@testable import lostfilm
import XCTest

class HTTPCookieStorageMock: HTTPCookieStorageable {
    private var attributes: [URL: [HTTPCookie]] = [:]

    init(with cookies: [HTTPCookie], for url: URL) {
        attributes[url] = cookies
    }

    init() {
        //
    }

    func cookies(for url: URL) -> [HTTPCookie]? {
        return attributes[url]
    }
}
