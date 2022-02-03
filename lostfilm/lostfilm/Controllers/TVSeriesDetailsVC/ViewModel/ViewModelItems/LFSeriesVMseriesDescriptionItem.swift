import Foundation

class LFSeriesVMseriesDescriptionItem: LFSeriesVMitem {
    var type: LFSeriesModelItemType {
        return .description
    }
    
    var seriesDescription: String
    
    init(seriesDescription: String) {
        self.seriesDescription = seriesDescription
    }
}
