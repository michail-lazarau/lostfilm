import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class PhotosVM: NSObject, NetworkDataReceiver {
    typealias DataModel = LFPhotoModel
    var dataProvider: TVSeriesDetailsAbstractPaginatingDC<LFPhotoModel>?
}
