import Foundation

class NetworkService {
    private static let lfSessionDefault: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return URLSession(configuration: configuration)
    }()

    func sendRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkService.lfSessionDefault.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
}
