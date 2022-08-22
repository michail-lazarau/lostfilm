import Foundation

final class TVSeriesCastDataProvider: BaseDataProvider, IHaveDataModelFetchedOnce {
    func getItemListForSeries(completionHandler: @escaping ([LFPersonModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getCastForSeries(byId: tvSeriesModel.id) { castList, error in
            completionHandler(castList, error as NSError?)
        }
    }
}
