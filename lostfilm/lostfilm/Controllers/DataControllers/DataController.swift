import Foundation

class DataController {
    var delegate: DataControllerDelegate?
    private var itemList: [LFSeriesModel] = []
    private var currentPage: UInt = 1
    var count: Int {
        itemList.count
    }

    init() {
        // empty
    }

    func getNextItemList() {
        getItemListForPage(number: currentPage) { [weak self] itemList, _ in
            guard let strongWeak = self
            else { return }
            strongWeak.itemList += itemList ?? []

            DispatchQueue.main.async {
                if let delegate = self?.delegate {
                    delegate.didLoad()
                }
            }
        }
    }

    private func getItemListForPage(number: UInt, completionHander: @escaping ([LFSeriesModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getListForPage(number, completionHandler: { seriesList, error in
            completionHander(seriesList, error as NSError?)
        })
    }
}

extension DataController {
    subscript(index: Int) -> LFSeriesModel {
        itemList[index]
    }
}
