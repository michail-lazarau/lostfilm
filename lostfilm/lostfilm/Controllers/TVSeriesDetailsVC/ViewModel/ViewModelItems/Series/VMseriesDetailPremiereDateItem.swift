import Foundation

class VMseriesDetailPremiereDateItem: VMseriesItem {
    var type: SeriesModelItemType {
        return .detailPremiereDate
    }
    
    var premiereDate: Date
    
    init(premiereDate: Date) {
        self.premiereDate = premiereDate
    }
}
