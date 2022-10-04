import Foundation

protocol ILoginServiceable {
    associatedtype URLSession: URLSessionProtocol
    var session: URLSession { get set }
    func login(eMail: String, password: String, response: @escaping (Result<String, Error>) -> Void)
}

extension ILoginServiceable {
    func getLoginPage(htmlParserWrapper: DVHtmlToModels = DVHtmlToModels(contextByName: "GetLoginPageContext"), response: @escaping (Result<LFLoginPageModel, Error>) -> Void) {
        htmlParserWrapper.loadData(withReplacingURLParameters: nil, queryURLParameters: nil, asJSON: true) { data, htmlData in
            let filteredData: [Any]? = data?[String(describing: LFLoginPageModel.self)] as? [Any] ?? nil
            if let loginFormProperties = filteredData?.first as? [AnyHashable: Any] {
                response(.success(LFLoginPageModel(data: loginFormProperties)))
            } else if htmlData == nil {
                response(.failure(DVHtmlError.failedToLoadOnUrl))
            } else {
                response(.failure(DVHtmlError.failedToParseWebElement))
            }
        }
    }

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
}
