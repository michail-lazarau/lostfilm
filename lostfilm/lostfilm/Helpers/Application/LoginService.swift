import Foundation

    final class LoginService<T: URLSessionProtocol>: LoginServiceProtocol {
    var session: T

    init(session: T) {
        self.session = session
    }

        func login(eMail: String, password: String, captcha: String?, response: @escaping (Result<String, Error>) -> Void) {
        do {
            let request = try composeLoginRequest(username: eMail, password: password, captcha: captcha)
            login(request: request, response: response)
        } catch let requestError {
            response(.failure(requestError))
        }
    }
}

extension LoginService {

    private func login(request: URLRequest, response: @escaping (Result<String, Error>) -> Void) {
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
                    } else if decodedData.error == 4 {
                        response(.failure(LoginServiceError.invalidCaptcha))
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
    private func composeLoginRequest(username: String, password: String, captcha: String?) throws -> URLRequest {
        var requestComponents = URLComponents() // for "x-www-form-urlencoded" content type
        requestComponents.queryItems = [
            URLQueryItem(name: "act", value: "users"),
            URLQueryItem(name: "type", value: "login"),
            URLQueryItem(name: "mail", value: username),
            URLQueryItem(name: "pass", value: password),
            URLQueryItem(name: "need_captcha", value: captcha == nil ? "0" : "1"), // seemingly the value doesn't effect the response
            URLQueryItem(name: "captcha", value: captcha),
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
    case invalidCredentials, needCaptcha, invalidCaptcha, unknownLoginError

    public var errorDescription: String? {
        switch self {
        case .invalidCredentials: return "Login invalid credentials"
        case .needCaptcha: return "Need to pass captcha" // MARK: occurs when captcha appears for the 1st time
        case .invalidCaptcha: return "Picture code was not specified correctly" // MARK: occurs when captcha was requested and was not specified correctly
        case .unknownLoginError: return "Error occurred during login"
        }
    }
}
