import Foundation

class VideosDataController: TemplateDataController<LFVideoModel> {
    override func getItemListForPage(number: UInt, completionHander: @escaping ([LFVideoModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.shared
        apiHelper.videos.getVideoList(forPage: number, completionHandler: { videosList, error in
            completionHander(videosList, error as NSError?)
        })
    }
}
