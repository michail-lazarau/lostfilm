import Foundation

class LFSeriesVMdetailChannelCountryItem: LFSeriesVMitem {
    var type: LFSeriesModelItemType {
        return .detailChannelCountry
    }
    
    var channels: String
    var country: String
    
    init(channels: String, country: String) {
        self.channels = channels
        self.country = country
    }
}
