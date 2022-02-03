import Foundation

protocol LFSeriesVMitem {
    var type: LFSeriesModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}
