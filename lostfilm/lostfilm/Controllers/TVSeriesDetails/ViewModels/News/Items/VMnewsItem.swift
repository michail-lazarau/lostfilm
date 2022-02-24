import Foundation

class VMnewsItem {
    var rowCount: Int {
        return newsList.count
    }
    
    var newsList: [LFNewsModel]
    
    init(newsList: [LFNewsModel]) {
        self.newsList = newsList
    }
}
