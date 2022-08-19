import Foundation

protocol ILoadingHeterogeneousItemsAllAtOnce: AnyObject {
    associatedtype ModelType
    func splitDataModelToItems(_ dataModel: ModelType)
}

extension ILoadingHeterogeneousItemsAllAtOnce {
    func loadItems<P: BaseDataProvider>(dataProvider: P, async completionHandler: @escaping () -> Void) where P: IHaveDataModelFetched {
        dataProvider.getItemListForSeriesBy { [weak self] itemList, _ in
            guard let strongSelf = self, let itemList = itemList else {
                return
            }
            strongSelf.splitDataModelToItems(itemList as! Self.ModelType)
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
}
