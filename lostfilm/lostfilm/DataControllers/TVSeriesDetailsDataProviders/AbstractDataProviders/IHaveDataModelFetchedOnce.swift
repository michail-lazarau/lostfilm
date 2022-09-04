import Foundation

// FIXME: is AnyObject unnecessary?
protocol IHaveDataModelFetchedOnce: AnyObject {
    associatedtype DataModel
    func fetchData(completionHandler: @escaping (DataModel?, NSError?) -> Void)
}
