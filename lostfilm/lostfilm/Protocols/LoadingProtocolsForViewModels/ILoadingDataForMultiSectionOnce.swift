import Foundation

protocol ILoadingDataForMultiSectionOnce: AnyObject {
    associatedtype ModelType
    func prepareDataModelForUse(_ dataModel: ModelType)
}

extension ILoadingDataForMultiSectionOnce {
    func loadItems<P: BaseDataProvider>(dataProvider: P, async completionHandler: @escaping () -> Void) where P: IHaveDataModelFetchedOnce {
        dataProvider.getItemListForSeries { [weak self] itemList, _ in
            guard let strongSelf = self, let itemList = itemList else {
                return
            }
            strongSelf.prepareDataModelForUse(itemList as! Self.ModelType)
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
}
