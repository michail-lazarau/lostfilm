import Foundation

protocol IHaveDataModelFetchedByPage {
    associatedtype DataModel
    func getItemListForSeriesBy(pageNumber: UInt, completionHandler: @escaping ([DataModel]?, NSError?) -> Void)
}
