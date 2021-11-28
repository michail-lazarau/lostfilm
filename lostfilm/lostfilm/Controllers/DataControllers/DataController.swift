import Foundation

class DataController {
    private var itemList: [LFSeriesModel] = []
    private var currentPage: UInt = 0
    var count: Int {
        itemList.count
    }

    init() {
    }

    func getNextItemList() {
        getItemListForPage(number: currentPage) { [self] itemList, _ in

            // MARK: Implement #define ACValidArray(itemList)

            self.itemList += itemList
        }
    }

    private func getItemListForPage(number: UInt, completionHander: @escaping ([LFSeriesModel], NSError) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getListForPage(number, completionHandler: { seriesList, error in
            completionHander(seriesList!, error! as NSError)
        })
    }
}

extension DataController {
    subscript(index: Int) -> LFSeriesModel {
        itemList[index]
    }
}
