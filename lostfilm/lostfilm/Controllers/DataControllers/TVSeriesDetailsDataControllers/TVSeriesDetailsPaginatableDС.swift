import Foundation

protocol TVSeriesDetailsPaginatableDС {
    associatedtype DataModel: LFJsonObject
    
    var isLoading: Bool { get set }
    var currentPage: UInt { get set }
    var delegate: DelegateTVSeriesDCwithPagination? { get set }
    var tvSeriesModel: LFSeriesModel { get set }
    var itemList: [DataModel] { get set }
    
    func getVideoListForSeriesBy(seriesId: String, pageNumber: UInt, completionHander: @escaping ([DataModel]?, NSError?) -> Void)
    func calculateIndexPathsToReload(from newItemList: [DataModel])
    func didEmptyNewsList()
}
