import Foundation

class DataController<DataModel> where DataModel: LFJsonObject {
    
    var delegate: DataControllerDelegate?
    var isLoading: Bool = false
    private var itemList: [DataModel] = []
    private var currentPage: UInt = 0
    var count: Int {
        itemList.count
    }
    
    init() {
        // empty
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
                if let delegate = self?.delegate { // FIXME: strongSelf instead of self?
                    delegate.updateUIForTableWith(rowsRange: appendingSeriesRange)
                }
            }

            strongSelf.isLoading = false // MARK: must be within getSeriesListForPage() method, not outside of it
        }
    }
    
    internal func getItemListForPage(number: UInt, completionHander: @escaping ([DataModel]?, NSError?) -> Void) {
        preconditionFailure("This func must be overridden")
    }
}

extension DataController {
    subscript(index: Int) -> DataModel {
        itemList[index]
    }
    
    func DidEmptySeriesList() {
        itemList.removeAll()
        currentPage = 0
    }
}
