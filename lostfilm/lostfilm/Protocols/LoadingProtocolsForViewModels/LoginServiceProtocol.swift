import Foundation

protocol LoginServiceProtocol {
    func login(email: String, password: String, captcha: String?, response: @escaping (Result<String, Error>) -> Void)
    func getCaptcha(url: URL, response: @escaping (Result<Data, Error>) -> Void)
}

extension LoginServiceProtocol {
    func getLoginPage(htmlParserWrapper: DVHtmlToModels, response: @escaping (Result<LFLoginPageModel, Error>) -> Void) {
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
}
