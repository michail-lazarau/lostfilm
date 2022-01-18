import Foundation

protocol FilteringDelegate: AnyObject {
    func sendFiltersToTVSeriesTVC(filters: [LFSeriesFilterBaseModel])
}
