import Foundation

protocol ILoadingDataOnce: AnyObject {
    associatedtype ModelType
    func prepareDataModelForUse(_ dataModel: ModelType)
}

extension ILoadingDataOnce {
    func loadItems<P: BaseDataProvider>(dataProvider: P, async completionHandler: @escaping () -> Void) where P: IHaveDataModelFetchedOnce {
        dataProvider.fetchData { [weak self] data, _ in
            guard let strongSelf = self, let itemList = data as? Self.ModelType else {
                return
            }

            strongSelf.prepareDataModelForUse(itemList)
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
}
