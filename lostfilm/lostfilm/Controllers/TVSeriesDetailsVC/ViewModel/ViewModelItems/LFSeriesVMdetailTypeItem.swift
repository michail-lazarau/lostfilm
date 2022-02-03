import Foundation

class LFSeriesVMdetailTypeItem: LFSeriesVMitem {
    var type: LFSeriesModelItemType {
        return .detailType
    }
    
    var typeName: String
    
    init(type: String) {
        self.typeName = type
    }
}
