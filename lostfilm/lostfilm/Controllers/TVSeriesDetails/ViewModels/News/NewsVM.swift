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
    
    func setupVMwith(modelList: [LFNewsModel]) -> Range<Int>{
        let appendingNewsRange: Range<Int>
        if items.isEmpty {
            let newsItem = VMnewsItem(newsList: modelList)
            items.append(newsItem)
            appendingNewsRange = 0 ..< modelList.count
        } else {
            items.first?.newsList += modelList
            guard let newsList = items.first?.newsList else {
                return Range(0...0)
            }
            appendingNewsRange = newsList.count - modelList.count ..< newsList.count
        }
        return appendingNewsRange
    }
    
        func didEmptyNewsList() {
            items.removeAll()
            dataProvider?.currentPage = 0
        }
}
