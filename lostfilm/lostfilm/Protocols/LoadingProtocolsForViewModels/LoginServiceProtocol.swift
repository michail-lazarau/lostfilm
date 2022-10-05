import Foundation

protocol LoginServiceProtocol {
    func login(eMail: String, password: String, captcha: String?, response: @escaping (Result<String, Error>) -> Void)
}

extension LoginServiceProtocol {
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
}