import Foundation

protocol FilteringDelegate: AnyObject {
    func sendFiltersToTVSeriesDC(filters: [LFSeriesFilterBaseModel])
}
