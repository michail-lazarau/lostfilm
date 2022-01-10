import Foundation

protocol BaseFilterDelegate: AnyObject {
    func sendFiltersToFilteringTVC(filters: (key: String, values: Set<String>))
}
