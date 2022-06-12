import Foundation

protocol GlobalSearchItem {
    var type: GlobalSearchItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}
