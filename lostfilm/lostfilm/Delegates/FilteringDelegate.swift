import Foundation

protocol FilteringDelegate: AnyObject {
//    func sendFiltersToTVSeriesDC(filters: [LFSeriesFilterBaseModel])
    
    func add(filter: LFSeriesFilterBaseModel)
    
    func remove(filter: LFSeriesFilterBaseModel)
}
