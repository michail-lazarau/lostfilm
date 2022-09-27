import Foundation

class VMseriesDetailChannelCountryItem: VMseriesItem {
    var type: SeriesModelItemType {
        return .detailChannelCountry
    }

    var channels: String
    var country: String

    init(channels: String, country: String) {
        self.channels = channels
        self.country = country
    }
}
