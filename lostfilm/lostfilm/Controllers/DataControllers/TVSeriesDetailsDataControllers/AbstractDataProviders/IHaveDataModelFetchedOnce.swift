import Foundation

// FIXME: is AnyObject unnecessary?
protocol IHaveDataModelFetchedOnce: AnyObject {
    associatedtype DataModel
    func getItemListForSeries(completionHandler: @escaping (DataModel?, NSError?) -> Void)
}
