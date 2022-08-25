import Foundation

final class TVSeriesOverviewDataProvider: BaseDataProvider, IHaveDataModelFetchedOnce {
    func getItemListForSeries(completionHandler: @escaping (LFSeriesModel?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getDetailsForSeries(byId: tvSeriesModel.id, completionHandler: { seriesModel, error in
            completionHandler(seriesModel, error as NSError?)
        })
    }
}
