import Foundation

protocol NetworkDataDecodable {
     var service:NetworkService { get set }
}

extension NetworkDataDecodable {
    func dataRequest<T:Decodable>(request: URLRequest, response: @escaping (Result<T, Error>) -> Void) {
        service.sendRequest(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    response(.success(model))
                } catch let decodeError {
                    response(.failure(decodeError))
                }
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
}
