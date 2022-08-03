import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class NewsVM: NSObject, NetworkDataReceiver {
    typealias DataModel = LFNewsModel
    var dataProvider: TVSeriesDetailsAbstractPaginatingDC<LFNewsModel>?
}
