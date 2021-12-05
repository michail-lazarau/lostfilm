import Foundation

class DataController {
    var delegate: DataControllerDelegate?
    var loadMore: Bool = false
    private var seriesList: [LFSeriesModel] = []
    private var currentPage: UInt = 1
    var count: Int {
        seriesList.count
    }

    init() {
        // empty
    }

    func paginating() {
        if loadMore {
            return
        }
        loadMore = true
        currentPage += 1
        getNextSeriesList()
        loadMore = false
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
