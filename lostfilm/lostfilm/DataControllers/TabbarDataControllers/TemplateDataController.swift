import Foundation

class TemplateDataController<DataModel: LFJsonObject>: TabModuleInput {

    private let router: TemplateRouter
    weak var delegate: DataControllerDelegate?
    var isLoading: Bool = false
    private var itemList: [DataModel] = []
    private var currentPage: UInt = 0
    var count: Int {
        itemList.count
    }

    init(router: TemplateRouter) {
        self.router = router
    }

    func LoadingData() {
        if isLoading == true {
            return
        }
        isLoading = true
        currentPage += 1
        getNextItemList()
    }

    func getNextItemList() {
        getItemListForPage(number: currentPage) { [weak self] itemList, _ in
            guard let strongSelf = self
            else { return }

            let safeItemList: [DataModel] = itemList ?? [] // MARK: if "guard let > return" is used then spinner is not destroyed

            strongSelf.itemList += safeItemList
            let appendingSeriesRange = strongSelf.count - safeItemList.count ..< strongSelf.count
            DispatchQueue.main.async {
                strongSelf.delegate?.updateUIForTableWith(rowsRange: appendingSeriesRange)
            }

            strongSelf.isLoading = false // MARK: must be within getSeriesListForPage() method, not outside of it
        }
    }

    func getItemListForPage(number: UInt, completionHander: @escaping ([DataModel]?, NSError?) -> Void) {
        fatalError("This func must be overridden")
    }

    func didTapProfileButton() {
        print("TODO open profile screen")
    }

    func didTapSignInButton() {
        router.showLogin()
    }

    func showSignedInUserProfileButton(with userInitials: String) {
        delegate?.showSignedInUserProfileButton(with: userInitials)
    }

    func showSignedOutUserProfileButton() {
        delegate?.showSignedOutProfileButton()
    }
}

extension TemplateDataController {
    subscript(index: Int) -> DataModel {
        itemList[index]
    }

    func DidEmptyItemList() {
        itemList.removeAll()
        currentPage = 0
    }
}
