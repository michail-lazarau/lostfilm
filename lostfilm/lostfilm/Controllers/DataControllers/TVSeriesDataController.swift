import Foundation

class TVSeriesDataController: TemplateDataController<LFSeriesModel> {
    override func getItemListForPage(number: UInt, completionHander: @escaping ([LFSeriesModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getListForPage(number, completionHandler: { seriesList, error in
            completionHander(seriesList, error as NSError?)
        })
    }
    
//    func getItemListForPage(number: UInt, parameters: [String : AnyObject], completionHander: @escaping ([LFSeriesModel]?, NSError?) -> Void) {
//        let apiHelper = LFApplicationHelper.sharedApiHelper
//        apiHelper.series.getListForPage(number, parameters: parameters, completionHandler: { seriesList, error in
//            completionHander(seriesList, error as NSError?)
//        })
//    }
}
