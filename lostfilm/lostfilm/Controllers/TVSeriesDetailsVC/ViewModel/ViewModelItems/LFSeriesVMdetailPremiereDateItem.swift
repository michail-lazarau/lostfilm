import Foundation

class LFSeriesVMdetailPremiereDateItem: LFSeriesVMitem {
    var type: LFSeriesModelItemType {
        return .detailPremiereDate
    }
    
    var premiereDate: Date
    
    init(premiereDate: Date) {
        self.premiereDate = premiereDate
    }
}
