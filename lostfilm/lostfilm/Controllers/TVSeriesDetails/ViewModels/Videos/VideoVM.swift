import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class VideoVM: NSObject {
    var rowCount: Int {
        return dataProvider?.videoList.count ?? 0
    }
    var videoList: [LFVideoModel] {
        return dataProvider?.videoList ?? []
    }
    
    var dataProvider: TVSeriesVideosDC?
    
    init(dataProvider: TVSeriesVideosDC) {
        super.init()
        self.dataProvider = dataProvider
    }
}
