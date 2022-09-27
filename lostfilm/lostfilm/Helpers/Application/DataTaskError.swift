import Foundation

public enum DataTaskError: LocalizedError {
    public typealias JSON = [String:Any]
    
    case generic
    case invalidURL
    case invalidJSON (_: String = "")
    case unexpectedResponseBody
    case httpRequestFailed(statusCode: UInt, json: JSON?)

    public var errorDescription: String? {
        switch self {
        case .generic: return "An error occurred."
        case .invalidURL: return "Invalid URL"
        case .invalidJSON: return "Invalid JSON."
        case .unexpectedResponseBody: return "Unexpected response body"
        case .httpRequestFailed(let statusCode, _): return "HTTP request failed with status code: \(statusCode)."
        }
    }
}

extension DataTaskError: Equatable {
    public static func == (lhs: DataTaskError, rhs: DataTaskError) -> Bool {
        type(of: lhs) == type(of: rhs) && lhs.localizedDescription == lhs.localizedDescription
    }
}
