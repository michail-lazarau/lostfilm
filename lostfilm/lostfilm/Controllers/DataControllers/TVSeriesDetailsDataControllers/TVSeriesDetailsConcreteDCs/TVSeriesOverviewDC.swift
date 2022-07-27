import Foundation

class TVSeriesOverviewDC: TVSeriesDetailsAbstractNonPaginatingDC<LFSeriesModel> {
    override func getItemListForSeriesBy(seriesId: String, completionHandler: @escaping (LFSeriesModel?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.sharedApiHelper.series
        apiHelper.getDetailsForSeries(byId: seriesId, completionHandler: { seriesModel, error in
            completionHandler(seriesModel, error as NSError?)
        })
    }
}
