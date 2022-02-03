import Foundation

class LFSeriesVMdetailOfficialSiteItem: LFSeriesVMitem {
    var type: LFSeriesModelItemType {
        return .detailOfficialSite
    }
    
    var officialSiteUrl: URL
    
    init(officialSiteUrl: URL) {
        self.officialSiteUrl = officialSiteUrl
    }
}
