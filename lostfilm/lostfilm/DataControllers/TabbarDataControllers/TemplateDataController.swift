import Foundation

class TemplateDataController<DataModel> where DataModel: LFJsonObject {
    typealias Routes = LoginRoute
    private(set) var router: Routes?
    weak var delegate: DataControllerDelegate?
    var isLoading: Bool = false
    private var itemList: [DataModel] = []
    private var currentPage: UInt = 0
    var count: Int {
        itemList.count
    }

    init(router: Routes) {
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

    internal func getItemListForPage(number: UInt, completionHander: @escaping ([DataModel]?, NSError?) -> Void) {
        fatalError("This func must be overridden")
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

    func openLogin() {
        router?.openLogin()
    }
}
