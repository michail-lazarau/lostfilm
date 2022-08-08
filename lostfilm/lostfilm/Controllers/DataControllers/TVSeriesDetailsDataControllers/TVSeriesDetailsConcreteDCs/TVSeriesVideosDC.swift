import Foundation

final class TVSeriesVideosDC: BaseDataProvider, IHaveDataModelFetchedByPage {
    func getItemListForSeriesBy(pageNumber: UInt, completionHandler: @escaping ([LFVideoModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getVideoListForSeries(byId: tvSeriesModel.id, page: pageNumber) { videoList, error in
            completionHandler(videoList, error as NSError?)
        }
    }
}
