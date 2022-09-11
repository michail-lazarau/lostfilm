import Foundation

final class LoginService {
    let service: NetworkService

    init(service: NetworkService) {
        self.service = service
    }

    func login(userLogin: String, password: String, response: @escaping (Result<String, Error>) -> Void) {
        do {
            let request = try composeLoginRequest(username: userLogin, password: password)
            login(request: request, response: response)
        } catch let requestError {
            response(.failure(requestError))
        }
    }
}

private extension LoginService {
    private func login(request: URLRequest, response: @escaping (Result<String, Error>) -> Void) {
        service.sendRequest(request: request) { result in
            switch result {
            case let .success(data):
                do {
                    let decodedData = try JSONDecoder().decode(UserLoginResponse.self, from: data)
                    if decodedData.error == nil, decodedData.name != nil {
                        response(.success(decodedData.name!))
                    } else if decodedData.needCaptcha == true {
                        response(.failure(LoginServiceError.needCaptcha))
                    } else {
                        response(.failure(LoginServiceError.invalidCredentials))
                    }
                } catch let decodeError {
                    response(.failure(decodeError))
                }
            case let .failure(error):
                response(.failure(error))
            }
        }
    }

    // https://medium.com/@serge.works.io/swift-how-to-create-a-http-post-request-with-application-x-www-form-urlencoded-body-bfd9cd26d6d5
    private func composeLoginRequest(username: String, password: String) throws -> URLRequest {
        var requestComponents = URLComponents() // for "x-www-form-urlencoded" content type
        requestComponents.queryItems = [
            URLQueryItem(name: "act", value: "users"),
            URLQueryItem(name: "type", value: "login"),
            URLQueryItem(name: "mail", value: username),
            URLQueryItem(name: "pass", value: password),
            URLQueryItem(name: "need_captcha", value: nil), // value doesn't effect the response
            URLQueryItem(name: "captcha", value: nil),
            URLQueryItem(name: "rem", value: "1")
        ]
        let body = requestComponents.query?.data(using: .utf8)

        return try Request.compose(url: "https://www.lostfilm.tv/ajaxik.users.php", method: HTTPMethod.post, headers: [.referer("https://www.lostfilm.tv"), .contentType("application/x-www-form-urlencoded"), .cacheControl("no-cache")], query: nil, body: body)
    }
}

private extension LoginService {
    enum LoginServiceError: LocalizedError {
        case invalidCredentials, needCaptcha

        public var errorDescription: String? {
            switch self {
            case .invalidCredentials: return "Login invalid credentials"
            case .needCaptcha: return "Need to pass captcha"
            }
        }
    }
}
