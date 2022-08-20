import Foundation

// FIXME: is AnyObject unnecessary?
protocol IHaveDataModelFetched: AnyObject {
    associatedtype DataModel
    func getItemListForSeries(completionHandler: @escaping (DataModel?, NSError?) -> Void)
}
