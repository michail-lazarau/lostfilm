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

    func paginating() {
        if isLoading == true {
            return
        }
        isLoading = true
        currentPage += 1
        getNextSeriesList()
        currentPage += 5000 // FIXME: delete later, test purpose
    }

    func getNextSeriesList() {
        getSeriesListForPage(number: currentPage) { [weak self] itemList, _ in
            guard let strongSelf = self
            else { return }
            guard let itemList = itemList
            else { return }
            strongSelf.seriesList += itemList
            let appendingSeriesRange = strongSelf.count - itemList.count ..< strongSelf.count
            DispatchQueue.main.async {
                if let delegate = self?.delegate { // FIXME: strongWeak instead of self?
                    delegate.updateUIForTableWith(rowsRange: appendingSeriesRange)
                }
            }
            strongSelf.isLoading = false // must be within getSeriesListForPage() method, not outside of it
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
}
