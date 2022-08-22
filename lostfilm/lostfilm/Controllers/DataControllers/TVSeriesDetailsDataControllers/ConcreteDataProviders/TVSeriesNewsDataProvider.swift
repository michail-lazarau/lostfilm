import Foundation

final class TVSeriesNewsDataProvider: BaseDataProvider, IHaveDataModelFetchedByPage {
    func getItemListForSeriesBy(page number: UInt, completionHandler: @escaping ([LFNewsModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getNewsListForSeries(byId: tvSeriesModel.id, page: number) { newsList, error in
            completionHandler(newsList, error as NSError?)
        }
    }
}
