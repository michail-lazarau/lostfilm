import Foundation

final class LoginViewModel<T: ILoginServiceable> {
    weak var viewUpdatingDelegate: IUpdatingViewDelegate?
    let dataProvider: T
    var username: String?
    var pageModel: LFLoginPageModel?
    var onFailure: ((Error) -> Void)? // TODO: implementation for nil and error type

    init(dataProvider: T) {
        self.dataProvider = dataProvider
    }

    func login(eMail: String, password: String) {
        getLoginPageDump()
        dataProvider.login(eMail: eMail, password: password) { [weak self] result in
            switch result {
            case let .success(username):
                self?.username = username
            case let .failure(error):
                self?.onFailure?(error)
            }

            DispatchQueue.main.async {
                self?.viewUpdatingDelegate?.updateView()
            }
        }
    }

    private func getLoginPageDump() {
        dataProvider.getLoginPage { [weak self] result in
            switch result {
            case let .success(success):
                self?.pageModel = success
            case let .failure(error):
                self?.onFailure?(error)
            }

            DispatchQueue.main.async {
                self?.viewUpdatingDelegate?.updateView()
            }
        }
    }
}
