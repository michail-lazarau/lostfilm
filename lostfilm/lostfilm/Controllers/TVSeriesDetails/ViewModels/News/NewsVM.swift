import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class NewsVM: NSObject {
    var rowCount: Int {
        return dataProvider?.itemList.count ?? 0
    }
    var newsList: [LFNewsModel] {
        return dataProvider?.itemList ?? []
    }
    
    var dataProvider: TVSeriesNewsDC?
    
    init(dataProvider: TVSeriesNewsDC) {
        super.init()
        self.dataProvider = dataProvider
    }
}
