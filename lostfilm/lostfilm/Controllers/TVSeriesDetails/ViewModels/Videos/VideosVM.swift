import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class VideosVM: NSObject, NetworkDataReceiver {
    typealias DataModel = LFVideoModel
    var dataProvider: TVSeriesDetailsAbstractPaginatingDC<LFVideoModel>?
}
