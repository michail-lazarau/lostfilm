import Foundation

protocol ILoadingDataByPage: AnyObject {
    associatedtype ModelType
    var currentPage: UInt { get set }
    var isLoading: Bool { get set }
    var items: [ModelType] { get set }
}

extension ILoadingDataByPage {
    func didEmptyItemList() {
        items.removeAll()
        currentPage = 0
    }

    func loadItemsByPage<P: BaseDataProvider>(dataProvider: P, async completionHandler: @escaping ([IndexPath]?) -> Void) where P: IHaveDataModelFetchedByPage {
        if isLoading == true {
            return
        }
        isLoading = true
        currentPage += 1
        loadItems(for: currentPage, dataProvider: dataProvider) { indexPaths in
            completionHandler(indexPaths)
        }
        isLoading = false
    }

    private func loadItems<P: BaseDataProvider>(for page: UInt, dataProvider: P, async completionHandler: @escaping ([IndexPath]?) -> Void) where P: IHaveDataModelFetchedByPage {
        dataProvider.fetchData(page: page) { [weak self] data, _ in
            let indexPathToReload: [IndexPath]?
            if let strongSelf = self, let itemList = data as? [Self.ModelType] {
                strongSelf.items += itemList
                if strongSelf.currentPage > 1 {
                    indexPathToReload = strongSelf.calculateIndexPathsToReload(from: itemList)
                } else {
                    indexPathToReload = .none
                }
            } else {
                self?.currentPage -= 1
                indexPathToReload = .none
            }
            DispatchQueue.main.async {
                completionHandler(indexPathToReload)
            }
        }
    }

    private func calculateIndexPathsToReload(from newItemList: [ModelType]) -> [IndexPath] {
        let startIndex = self.items.count - newItemList.count
        let endIndex = startIndex + newItemList.count
        return (startIndex ..< endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
