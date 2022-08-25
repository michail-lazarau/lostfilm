import Foundation

final class TVSeriesPhotosDataProvider: BaseDataProvider, IHaveDataModelFetchedByPage {
    func getItemListForSeriesBy(page number: UInt, completionHandler: @escaping ([LFPhotoModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.shared.series
        apiHelper.getPhotoListForSeries(byId: tvSeriesModel.id, page: number) { photoList, error in
            completionHandler(photoList, error as NSError?)
        }
    }
}
