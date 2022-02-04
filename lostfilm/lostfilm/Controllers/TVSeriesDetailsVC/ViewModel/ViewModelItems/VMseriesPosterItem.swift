import Foundation

class VMseriesPosterItem: VMseriesItem {
    var type: SeriesModelItemType {
        return .poster
    }
    
    var posterUrl: URL
    var rating: Double
    
    init(posterUrl: URL, rating: Double) {
        self.posterUrl = posterUrl
        self.rating = rating
    }
}
