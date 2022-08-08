import Foundation

protocol ILoadingHeterogeneousItems: AnyObject {
    associatedtype ModelType
    func loadItems() // MARK: call the func inside: loadItems<DataProvider: IHaveDataModelBySeriesId>(dataProvider: DataProvider, async completionHandler: @escaping () -> Void) 
    func loadItems<DataProvider: IHaveDataModelFetched>(dataProvider: DataProvider, async completionHandler: @escaping () -> Void)
    func setupVMwith(model: ModelType)
}

extension ILoadingHeterogeneousItems {
    func loadItems<P: IHaveDataModelFetched>(dataProvider: P, async completionHandler: @escaping () -> Void) {
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
