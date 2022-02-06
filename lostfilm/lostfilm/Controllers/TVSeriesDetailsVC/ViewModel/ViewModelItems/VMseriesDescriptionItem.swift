import Foundation

class VMseriesDescriptionItem: VMseriesItem {
    var type: SeriesModelItemType {
        return .description
    }
    
    var seriesDescription: String
    
    init(seriesDescription: String) {
        self.seriesDescription = seriesDescription
    }
}
