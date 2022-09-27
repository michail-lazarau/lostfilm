import Foundation

extension VMseriesItem {
    var rowCount: Int {
        return 1
    }

    var sectionTitle: String {
        return type.rawValue
    }
}
