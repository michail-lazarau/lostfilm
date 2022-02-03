import Foundation

class LFSeriesVMposterItem: LFSeriesVMitem {
    var type: LFSeriesModelItemType {
        return .poster
    }
    
    var posterUrl: URL
    var rating: Double
    
    init(posterUrl: URL, rating: Double) {
        self.posterUrl = posterUrl
        self.rating = rating
    }
}
