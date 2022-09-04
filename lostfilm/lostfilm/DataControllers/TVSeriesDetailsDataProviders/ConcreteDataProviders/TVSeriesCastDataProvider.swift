import Foundation

final class TVSeriesCastDataProvider: BaseDataProvider, IHaveDataModelFetchedOnce {
    func fetchData(completionHandler: @escaping ([LFPersonModel]?, NSError?) -> Void) {
        apiHelper.series.getCastForSeries(byId: modelId) { castList, error in
            completionHandler(castList, error as NSError?)
        }
    }
}
