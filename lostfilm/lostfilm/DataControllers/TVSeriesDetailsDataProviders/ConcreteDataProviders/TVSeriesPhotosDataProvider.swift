import Foundation

final class TVSeriesPhotosDataProvider: BaseDataProvider, IHaveDataModelFetchedByPage {
    func fetchData(page number: UInt, completionHandler: @escaping ([LFPhotoModel]?, NSError?) -> Void) {
        apiHelper.series.getPhotoListForSeries(byId: modelId, page: number) { photoList, error in
            completionHandler(photoList, error as NSError?)
        }
    }
}
