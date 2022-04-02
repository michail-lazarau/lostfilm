import Foundation

protocol DataControllerDelegate: AnyObject {
    func updateUIForTableWith(rowsRange: Range<Int>)
}
