import Foundation

final class TVSeriesNewsDC: TVSeriesDetailsAbstractPaginatingDC<LFNewsModel> {
    override func getItemListForSeriesBy(seriesId: String, pageNumber: UInt, completionHandler: @escaping ([LFNewsModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.sharedApiHelper.series
        apiHelper.getNewsListForSeries(byId: seriesId, page: pageNumber) { newsList, error in
            completionHandler(newsList, error as NSError?)
        }
    }
}
