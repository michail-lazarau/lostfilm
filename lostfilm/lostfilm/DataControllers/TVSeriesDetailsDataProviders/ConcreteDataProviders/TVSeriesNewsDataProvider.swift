import Foundation

final class TVSeriesNewsDataProvider: BaseDataProvider, IHaveDataModelFetchedByPage {
    func fetchData(page number: UInt, completionHandler: @escaping ([LFNewsModel]?, NSError?) -> Void) {
        apiHelper.series.getNewsListForSeries(byId: modelId, page: number) { newsList, error in
            completionHandler(newsList, error as NSError?)
        }
    }
}
