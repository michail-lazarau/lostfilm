import Foundation

protocol URLSessionProtocol {
    associatedtype ReturnType: URLSessionDataTaskProtocol
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> ReturnType
    func dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> ReturnType
}

extension URLSessionProtocol {
    // MARK: hide session: Self parameter?

    func sendRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
}

extension URLSession: URLSessionProtocol {
}
