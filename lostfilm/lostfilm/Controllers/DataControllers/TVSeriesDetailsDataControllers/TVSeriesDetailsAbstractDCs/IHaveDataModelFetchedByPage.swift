import Foundation

protocol IHaveDataModelFetchedByPage {
    associatedtype DataModel: LFJsonObject
    func getItemListForSeriesBy(pageNumber: UInt, completionHandler: @escaping ([DataModel]?, NSError?) -> Void)
}
