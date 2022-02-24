import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class NewsVM: NSObject {
    var items = [VMnewsItem]() // single element inside
    var dataProvider: TVSeriesNewsDC?
    
    override init() {
        super.init()
    }
    
    init(dataProvider: TVSeriesNewsDC) {
        super.init()
        self.dataProvider = dataProvider
    }
    
    func setupVMwith(modelList: [LFNewsModel]) {
        let newsItem = VMnewsItem(newsList: modelList)
        items.append(newsItem)
    }
}
