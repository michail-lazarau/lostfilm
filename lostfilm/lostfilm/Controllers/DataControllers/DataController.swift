import Foundation

class DataController {
    var delegate: DataControllerDelegate?
    var isLoading: Bool = false
    private var seriesList: [LFSeriesModel] = []
    private var currentPage: UInt = 0
    var count: Int {
        seriesList.count
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
        getNextSeriesList()
    }

    func getNextSeriesList() {
        getSeriesListForPage(number: currentPage) { [weak self] itemList, _ in
            guard let strongSelf = self
            else { return }

            let safeItemList: [LFSeriesModel] = itemList ?? [] // MARK: if "guard let > return" is used then spinner is not destroyed

            strongSelf.seriesList += safeItemList
            let appendingSeriesRange = strongSelf.count - safeItemList.count ..< strongSelf.count
            DispatchQueue.main.async {
                if let delegate = self?.delegate { // FIXME: strongSelf instead of self?
                    delegate.updateUIForTableWith(rowsRange: appendingSeriesRange)
                }
            }

            strongSelf.isLoading = false // MARK: must be within getSeriesListForPage() method, not outside of it
        }
    }

    private func getSeriesListForPage(number: UInt, completionHander: @escaping ([LFSeriesModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getListForPage(number, completionHandler: { seriesList, error in
            completionHander(seriesList, error as NSError?)
        })
    }
}

extension DataController {
    subscript(index: Int) -> LFSeriesModel {
        seriesList[index]
    }
    
    func DidEmptySeriesList() {
        seriesList.removeAll()
        currentPage = 0
    }
}
