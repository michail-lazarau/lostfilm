import Foundation

final class TVSeriesPhotosDC: TVSeriesDetailsAbstractPaginatingDC<LFPhotoModel> {
    override func getItemListForSeriesBy(seriesId: String, pageNumber: UInt, completionHandler: @escaping ([LFPhotoModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.sharedApiHelper.series
        apiHelper.getPhotoListForSeries(byId: seriesId, page: pageNumber) { photoList, error in
            completionHandler(photoList, error as NSError?)
        }
    }
}
