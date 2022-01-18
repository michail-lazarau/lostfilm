import Foundation

class NewsDataController: TemplateDataController<LFNewsModel> {
    override func getItemListForPage(number: UInt, completionHander: @escaping ([LFNewsModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.news.getListForPage(number, completionHandler: { newsList, error in
            completionHander(newsList, error as NSError?)
        })
    }
}
