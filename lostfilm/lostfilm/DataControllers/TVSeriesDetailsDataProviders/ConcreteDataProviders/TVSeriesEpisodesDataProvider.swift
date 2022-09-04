import Foundation

final class TVSeriesEpisodesDataProvider: BaseDataProvider, IHaveDataModelFetchedOnce {
    func fetchData(completionHandler: @escaping ([LFSeasonModel]?, NSError?) -> Void) {
        apiHelper.series.getSeriesGuideForSeries(byId: modelId, completionHandler: { seasonList, error in
            completionHandler(seasonList, error as NSError?)
        })
    }
}
