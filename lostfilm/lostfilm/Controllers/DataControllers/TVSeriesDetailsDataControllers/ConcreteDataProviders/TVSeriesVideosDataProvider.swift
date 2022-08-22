import Foundation

final class TVSeriesVideosDataProvider: BaseDataProvider, IHaveDataModelFetchedByPage {
    func getItemListForSeriesBy(page number: UInt, completionHandler: @escaping ([LFVideoModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getVideoListForSeries(byId: tvSeriesModel.id, page: number) { videoList, error in
            completionHandler(videoList, error as NSError?)
        }
    }
}
