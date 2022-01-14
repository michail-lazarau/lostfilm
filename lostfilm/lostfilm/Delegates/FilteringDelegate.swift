import Foundation

protocol FilteringDelegate: AnyObject {
    func sendFiltersToTVSeriesTVC(filters: [String : Set<String>])
}
