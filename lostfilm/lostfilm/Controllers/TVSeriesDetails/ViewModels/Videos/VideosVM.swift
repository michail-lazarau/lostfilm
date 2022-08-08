import Foundation

class VideosVM: BaseViewModel<TVSeriesVideosDC, LFVideoModel> {
    private var currentPage: UInt = 0
    private var isLoading: Bool = false
    weak var delegate: IUpdatingViewPaginatedDelegate?
    
    func loadItemsByPage() {
        if isLoading == true {
            return
        }
        isLoading = true
        currentPage += 1
        loadItems(for: currentPage)
        isLoading = false
    }
    
    func didEmptyItemList() {
        items.removeAll()
        currentPage = 0
    }
    
    func loadItems(for page: UInt) {
        dataProvider.getItemListForSeriesBy(pageNumber: page) { [weak self] itemList, _ in
            guard let strongSelf = self, let itemList = itemList else {
                self?.currentPage -= 1
                return
            }
            strongSelf.items += itemList

            DispatchQueue.main.async {
                if strongSelf.currentPage > 1 {
                    let indexPathToReload = strongSelf.calculateIndexPathsToReload(from: itemList)
                    strongSelf.delegate?.updateTableView(with: indexPathToReload)
                } else {
                    strongSelf.delegate?.updateTableView(with: .none)
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newItemList: [LFJsonObject]) -> [IndexPath] {
        let startIndex = items.count - newItemList.count
        let endIndex = startIndex + newItemList.count
        return (startIndex ..< endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
