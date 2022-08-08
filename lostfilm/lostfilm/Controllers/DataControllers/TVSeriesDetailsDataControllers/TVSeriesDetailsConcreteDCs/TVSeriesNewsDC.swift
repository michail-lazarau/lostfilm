import Foundation

final class TVSeriesNewsDC: BaseDataProvider, IHaveDataModelFetchedByPage {
    func getItemListForSeriesBy(pageNumber: UInt, completionHandler: @escaping ([LFNewsModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getNewsListForSeries(byId: tvSeriesModel.id, page: pageNumber) { newsList, error in
            completionHandler(newsList, error as NSError?)
        }
    }
}
