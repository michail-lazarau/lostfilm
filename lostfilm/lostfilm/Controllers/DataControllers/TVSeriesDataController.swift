import Foundation

class TVSeriesDataController: DataController<LFSeriesModel> {
    
    override func getItemListForPage(number: UInt, completionHander: @escaping ([LFSeriesModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getListForPage(number, completionHandler: { seriesList, error in
            completionHander(seriesList, error as NSError?)
        })
    }
}
