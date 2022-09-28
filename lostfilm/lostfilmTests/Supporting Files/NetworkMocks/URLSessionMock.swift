import Foundation
@testable import lostfilm

class URLSessionMock: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler) -> URLSessionDataTaskMock {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock{
            completionHandler(data, nil, error)
        }
    }
    
    func dataTask(with: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTaskMock {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock{
            completionHandler(data, nil, error)
        }
    }
}
