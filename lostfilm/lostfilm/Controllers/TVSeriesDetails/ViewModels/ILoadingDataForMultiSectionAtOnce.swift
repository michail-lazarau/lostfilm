import Foundation

protocol ILoadingDataForMultiSectionAtOnce: AnyObject {
    associatedtype ModelType
    func splitDataModelToItems(_ dataModel: ModelType)
}

extension ILoadingDataForMultiSectionAtOnce {
    func loadItems<P: BaseDataProvider>(dataProvider: P, async completionHandler: @escaping () -> Void) where P: IHaveDataModelFetched {
        dataProvider.getItemListForSeries { [weak self] itemList, _ in
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
