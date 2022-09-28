import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension HTTPMethod {
    static let connect = HTTPMethod(rawValue: "CONNECT").rawValue
    static let delete = HTTPMethod(rawValue: "DELETE").rawValue
    static let get = HTTPMethod(rawValue: "GET").rawValue
    static let head = HTTPMethod(rawValue: "HEAD").rawValue
    static let options = HTTPMethod(rawValue: "OPTIONS").rawValue
    static let patch = HTTPMethod(rawValue: "PATCH").rawValue
    static let post = HTTPMethod(rawValue: "POST").rawValue
    static let put = HTTPMethod(rawValue: "PUT").rawValue
    static let trace = HTTPMethod(rawValue: "TRACE").rawValue
}
