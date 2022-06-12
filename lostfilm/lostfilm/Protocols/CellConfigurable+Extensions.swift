import Foundation

extension CellConfigurable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
