import Foundation

protocol FilteringDelegate: AnyObject {
    func add(filter: LFSeriesFilterBaseModel)
    func remove(filter: LFSeriesFilterBaseModel)
}
