import Foundation

final class TVSeriesEpisodesDataProvider: BaseDataProvider, IHaveDataModelFetchedOnce {
    func getItemListForSeries(completionHandler: @escaping ([LFSeasonModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getSeriesGuideForSeries(byId: tvSeriesModel.id, completionHandler: { seasonList, error in
            completionHandler(seasonList, error as NSError?)
        })
    }
}
