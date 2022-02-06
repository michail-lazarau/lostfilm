import Foundation

class VMseriesDetailRatingIMDbItem: VMseriesItem {
    var type: SeriesModelItemType {
        return .detailRatingIMDb
    }
    
    var ratingIMDb: Double
    
    init(ratingIMDb: Double) {
        self.ratingIMDb = ratingIMDb
    }
}
