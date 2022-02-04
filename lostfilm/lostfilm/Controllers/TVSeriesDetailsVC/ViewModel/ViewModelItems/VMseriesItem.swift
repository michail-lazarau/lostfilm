import Foundation

protocol VMseriesItem {
    var type: SeriesModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}
