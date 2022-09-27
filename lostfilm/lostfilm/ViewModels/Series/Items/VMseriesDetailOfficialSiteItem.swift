import Foundation

class VMseriesDetailOfficialSiteItem: VMseriesItem {
    var type: SeriesModelItemType {
        return .detailOfficialSite
    }

    var officialSiteUrl: URL

    init(officialSiteUrl: URL) {
        self.officialSiteUrl = officialSiteUrl
    }
}
