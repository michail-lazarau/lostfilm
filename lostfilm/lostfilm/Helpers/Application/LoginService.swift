import Foundation

final class LoginService<T: URLSessionProtocol>  {
    let session: T
    
    init(session: T) {
        self.session = session
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

extension LoginService {
    func login(request: URLRequest, response: @escaping (Result<String, Error>) -> Void) {
        session.sendRequest(request: request) { result in
            switch result {
            case let .success(data):
                do {
                    let decodedData = try JSONDecoder().decode(UserLoginResponse.self, from: data)
                    if decodedData.error == nil, let username = decodedData.name {
                        response(.success(username))
                    } else if decodedData.needCaptcha == true {
                        response(.failure(LoginServiceError.needCaptcha))
                    } else if decodedData.error == 3 {
                        response(.failure(LoginServiceError.invalidCredentials))
                    } else {
                        response(.failure(LoginServiceError.unknownLoginError))
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
            URLQueryItem(name: "need_captcha", value: "0"), // seemingly the value doesn't effect the response
            URLQueryItem(name: "captcha", value: nil),
            URLQueryItem(name: "rem", value: "1")
        ]
        
        return try Request.compose(url: "https://www.lostfilm.tv/ajaxik.users.php",
                                   method: HTTPMethod.post,
                                   headers: [.referer("https://www.lostfilm.tv/login"), .contentType("application/x-www-form-urlencoded"), .cacheControl("no-cache")],
                                   query: nil,
                                   body: requestComponents.query?.data(using: .utf8))
    }
}

enum LoginServiceError: LocalizedError {
    case invalidCredentials, needCaptcha, unknownLoginError

    public var errorDescription: String? {
        switch self {
        case .invalidCredentials: return "Login invalid credentials"
        case .needCaptcha: return "Need to pass captcha"
        case .unknownLoginError: return "Error occurred during login"
        }
    }
}
