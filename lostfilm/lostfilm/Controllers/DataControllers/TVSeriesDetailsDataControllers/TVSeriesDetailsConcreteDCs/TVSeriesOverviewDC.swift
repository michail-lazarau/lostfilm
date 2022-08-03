import Foundation

final class TVSeriesOverviewDC: TVSeriesDetailsAbstractNonPaginatingDC<LFSeriesModel> {
    override func getItemListForSeriesBy(seriesId: String, completionHandler: @escaping (LFSeriesModel?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getDetailsForSeries(byId: seriesId, completionHandler: { seriesModel, error in
            completionHandler(seriesModel, error as NSError?)
        })
    }
}
