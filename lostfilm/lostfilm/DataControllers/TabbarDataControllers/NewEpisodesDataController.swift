import Foundation

class NewEpisodesDataController: TemplateDataController<LFEpisodeModel> {
    override func getItemListForPage(number: UInt, completionHander: @escaping ([LFEpisodeModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.shared
        apiHelper.series.getNewEpisodeList(forPage: number) { episodesList, error in
            completionHander(episodesList, error as NSError?)
        }
    }
}
