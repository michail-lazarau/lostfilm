import Foundation

protocol IHaveDataModelFetchedByPage {
    associatedtype DataModel: LFJsonObject
    func fetchData(page number: UInt, completionHandler: @escaping ([DataModel]?, NSError?) -> Void)
}
