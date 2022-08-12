import Foundation

protocol IHaveDataModelFetched: AnyObject {
    associatedtype DataModel
    
    func getItemListForSeriesBy(completionHandler: @escaping (DataModel?, NSError?) -> Void)
}
