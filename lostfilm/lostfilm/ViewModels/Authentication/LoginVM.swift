import Foundation

final class LoginViewModel<T, R> where T: LoginService<R>, R: URLSessionProtocol {
//    let dataProvider: LoginService<T> where T: URLSessionProtocol
    weak var viewUpdatingDelegate: IUpdatingViewDelegate?
    let dataProvider: T
    var username: String?
    var pageModel: LFLoginPageModel?
    var error: Error?

//    init<T: URLSessionProtocol>(dataProvider: LoginService<T>) {
//    }

    init(dataProvider: T) {
        self.dataProvider = dataProvider
    }

    func login(eMail: String, password: String) throws {
        var error: Error?
        try getLoginPageDump()
        dataProvider.login(eMail: eMail, password: password) { [weak self] result in
            switch result {
            case let .success(username):
                self?.username = username
            case let .failure(failure):
                error = failure
            }
        }
        if let error = error {
            throw error
        }

        DispatchQueue.main.async {
            self.viewUpdatingDelegate?.updateTableView()
        }
    }

    private func getLoginPageDump() throws {
        var error: Error?
        dataProvider.getLoginPage { [weak pageModel] result in
            switch result {
            case let .success(success):
                pageModel = success
            case let .failure(failure):
                error = failure
            }
        }
        if let error = error {
            throw error
        }
    }
}

//    var pageModel: LFLoginPageModel? {
//        get throws {
//            var model: LFLoginPageModel?
//            var error: Error?
//            dataProvider.getLoginPage { result in
//                switch result {
//                case let .success(success):
//                    model = success
//                case let .failure(failure):
//                    error = failure
//                }
//            }
//            guard let model = model else {
//                throw error!
//            }
//            return model
//        }
//    }
