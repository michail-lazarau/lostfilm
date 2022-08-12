import Foundation

protocol ILoadingHeterogeneousItems: AnyObject {
    associatedtype ModelType
    func loadItems() // MARK: call the func inside: loadItems<DataProvider: IHaveDataModelBySeriesId>(dataProvider: DataProvider, async completionHandler: @escaping () -> Void)
    func setupVMwith(model: ModelType)
}

extension ILoadingHeterogeneousItems {
    func loadItems<P: BaseDataProvider>(dataProvider: P, async completionHandler: @escaping () -> Void) where P: IHaveDataModelFetched {
        dataProvider.getItemListForSeriesBy { [weak self] itemList, _ in
            guard let strongSelf = self, let itemList = itemList else {
                return
            }
            strongSelf.setupVMwith(model: itemList as! Self.ModelType)
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
}
