import Foundation

class LFSeriesVMdetailGenreItem: LFSeriesVMitem {
    var type: LFSeriesModelItemType {
        return .detailGenre
    }
    
    var genre: String
    
    init(genre: String) {
        self.genre = genre
    }
}
