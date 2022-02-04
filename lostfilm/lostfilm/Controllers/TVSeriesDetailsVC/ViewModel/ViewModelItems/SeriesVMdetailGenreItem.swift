import Foundation

class SeriesVMdetailGenreItem: VMseriesItem {
    var type: SeriesModelItemType {
        return .detailGenre
    }
    
    var genre: String
    
    init(genre: String) {
        self.genre = genre
    }
}
