import Foundation

class GlobalSearchSeriesItem: GlobalSearchItem {
    var type: GlobalSearchItemType {
        return .series
    }
    
    var rowCount: Int {
        series.count
    }
    let series: [LFSeriesModel]
    
    init(seriesList: [LFSeriesModel]) {
        series = seriesList
    }
}
