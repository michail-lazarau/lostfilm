import Foundation

protocol IHaveDataModelFetchedByPage {
    associatedtype DataModel: LFJsonObject
    func getItemListForSeriesBy(page number: UInt, completionHandler: @escaping ([DataModel]?, NSError?) -> Void)
}
