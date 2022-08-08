import Foundation

final class TVSeriesPhotosDC: BaseDataProvider, IHaveDataModelFetchedByPage {
    func getItemListForSeriesBy(pageNumber: UInt, completionHandler: @escaping ([LFPhotoModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getPhotoListForSeries(byId: tvSeriesModel.id, page: pageNumber) { photoList, error in
            completionHandler(photoList, error as NSError?)
        }
    }
}
