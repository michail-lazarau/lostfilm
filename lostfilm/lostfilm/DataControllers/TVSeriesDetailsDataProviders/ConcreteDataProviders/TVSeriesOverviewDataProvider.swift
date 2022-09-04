import Foundation

final class TVSeriesOverviewDataProvider: BaseDataProvider, IHaveDataModelFetchedOnce {
    func fetchData(completionHandler: @escaping (LFSeriesModel?, NSError?) -> Void) {
        apiHelper.series.getDetailsForSeries(byId: modelId, completionHandler: { seriesModel, error in
            completionHandler(seriesModel, error as NSError?)
        })
    }
}
