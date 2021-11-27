import Foundation

class DataController {
    var itemList: [LFSeriesModel] = []
    var currentPage: UInt = 0

    init() {
    }

    func getNextItemList() {
        getItemListForPage(number: currentPage) { [self] itemList, error in
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
