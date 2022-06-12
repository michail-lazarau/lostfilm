import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class NewsVM: NSObject {
    var rowCount: Int {
        return dataProvider?.newsList.count ?? 0
    }
    var newsList: [LFNewsModel] {
        return dataProvider?.newsList ?? []
    }
    
    var dataProvider: TVSeriesNewsDC?
    
    init(dataProvider: TVSeriesNewsDC) {
        super.init()
        self.dataProvider = dataProvider
    }
}
