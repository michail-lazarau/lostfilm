import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class VideosVM: NSObject {
    var rowCount: Int {
        return dataProvider?.itemList.count ?? 0
    }
    var videoList: [LFVideoModel] {
        return dataProvider?.itemList ?? []
    }
    
    var dataProvider: TVSeriesVideosDC?
    
    init(dataProvider: TVSeriesVideosDC) {
        super.init()
        self.dataProvider = dataProvider
    }
}
