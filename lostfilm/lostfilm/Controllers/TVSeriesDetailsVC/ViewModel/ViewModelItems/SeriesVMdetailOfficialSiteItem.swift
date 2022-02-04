import Foundation

class SeriesVMdetailOfficialSiteItem: VMseriesItem {
    var type: SeriesModelItemType {
        return .detailOfficialSite
    }
    
    var officialSiteUrl: URL
    
    init(officialSiteUrl: URL) {
        self.officialSiteUrl = officialSiteUrl
    }
}
