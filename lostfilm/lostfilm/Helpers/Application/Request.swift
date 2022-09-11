import Foundation

// MARK: helper

class Request {
    // MARK: https://www.advancedswift.com/a-guide-to-urls-in-swift/

    static func compose(url: String, method: HTTPMethod.RawValue, headers: [HTTPHeader]?, query: [URLQueryItem]?, body: Data?) throws -> URLRequest {
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = query

        guard let url = urlComponents?.url else {
            throw DataTaskError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        if let headers = headers {
            request.allHTTPHeaderFields = headers.reduce(into: [:]) { $0[$1.name] = $1.value }
        }

        return request
    }
}
