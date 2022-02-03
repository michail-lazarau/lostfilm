import Foundation

class LFSeriesVMdetailRatingIMDbItem: LFSeriesVMitem {
    var type: LFSeriesModelItemType {
        return .detailRatingIMDb
    }
    
    var ratingIMDb: Double
    
    init(ratingIMDb: Double) {
        self.ratingIMDb = ratingIMDb
    }
}
