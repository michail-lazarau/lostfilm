import Foundation

class GlobalSearchSeriesItem: GlobalSearchItem {
    var type: GlobalSearchItemType {
        return .series
    }
    
    var rowCount: Int {
        series.count
    }
    private let series: [LFSeriesModel]
    
    init(seriesList: [LFSeriesModel]) {
        series = seriesList
    }
}

extension GlobalSearchSeriesItem {
    subscript(index: Int) -> LFSeriesModel {
        series[index]
    }
}
