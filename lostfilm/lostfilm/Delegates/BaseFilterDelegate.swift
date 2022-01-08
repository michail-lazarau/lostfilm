import Foundation

protocol BaseFilterDelegate: AnyObject {
    func sendFiltersToTVSeriesTVC(filters: (key: String, values: Set<String>))
}
