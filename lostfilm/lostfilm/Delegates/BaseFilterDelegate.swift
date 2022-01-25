import Foundation

protocol BaseFilterDelegate: AnyObject {
    func sendFiltersToFilteringTVC(filters: [LFSeriesFilterBaseModel], forKey: String?)
}
