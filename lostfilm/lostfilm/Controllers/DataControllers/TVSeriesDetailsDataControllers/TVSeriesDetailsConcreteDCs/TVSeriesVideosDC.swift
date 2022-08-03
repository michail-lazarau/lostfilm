import Foundation

final class TVSeriesVideosDC: TVSeriesDetailsAbstractPaginatingDC<LFVideoModel> {
    override func getItemListForSeriesBy(seriesId: String, pageNumber: UInt, completionHandler: @escaping ([LFVideoModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getVideoListForSeries(byId: seriesId, page: pageNumber) { videoList, error in
            completionHandler(videoList, error as NSError?)
        }
    }
}
