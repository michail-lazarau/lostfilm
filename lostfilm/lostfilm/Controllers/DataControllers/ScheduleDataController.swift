import Foundation

class ScheduleDataController : TemplateDataController<LFEpisodeModel> {
    
    override func getItemListForPage(number: UInt, completionHander: @escaping ([LFEpisodeModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getTimetableWithCompletionHandler { episodesList, error in
            completionHander(episodesList, error as NSError?)
        }
    }
}
