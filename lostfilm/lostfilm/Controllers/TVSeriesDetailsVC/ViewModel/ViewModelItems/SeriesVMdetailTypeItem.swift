import Foundation

class SeriesVMdetailTypeItem: VMseriesItem {
    var type: SeriesModelItemType {
        return .detailType
    }
    
    var typeName: String
    
    init(type: String) {
        self.typeName = type
    }
}
