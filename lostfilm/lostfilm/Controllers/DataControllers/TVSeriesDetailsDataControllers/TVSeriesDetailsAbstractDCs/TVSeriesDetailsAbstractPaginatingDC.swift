import Foundation

class TVSeriesDetailsAbstractPaginatingDC<DataModel>: TVSeriesDetailsAbstract where DataModel: LFJsonObject {
    var itemList: [DataModel] = []
    private var isLoading: Bool = false
    private var currentPage: UInt = 0
    weak var delegate: TVSeriesDetailsPaginatingDC_Delegate?

    func loadItemsByPage() {
        if isLoading == true {
            return
        }
        isLoading = true
        currentPage += 1
        getDetailsFor(page: currentPage)
    }

    func didEmptyNewsList() {
        itemList.removeAll()
        currentPage = 0
    }

    func getItemListForSeriesBy(seriesId: String, pageNumber: UInt, completionHandler: @escaping ([DataModel]?, NSError?) -> Void) {
        fatalError("This func must be overridden")
    }
}

private extension TVSeriesDetailsAbstractPaginatingDC {
    private func getDetailsFor(page: UInt) {
        getItemListForSeriesBy(seriesId: tvSeriesModel.id, pageNumber: page) { [weak self] itemList, _ in
            guard let strongSelf = self, let itemList = itemList else {
                return
            }
            strongSelf.itemList += itemList

            DispatchQueue.main.async {
                if strongSelf.currentPage > 1 {
                    let indexPathToReload = strongSelf.calculateIndexPathsToReload(from: itemList)
                    strongSelf.delegate?.updateTableView(with: indexPathToReload)
                } else {
                    strongSelf.delegate?.updateTableView(with: .none)
                }
            }
            strongSelf.isLoading = false
        }
    }

    private func calculateIndexPathsToReload(from newItemList: [DataModel]) -> [IndexPath] {
        let startIndex = itemList.count - newItemList.count
        let endIndex = startIndex + newItemList.count
        return (startIndex ..< endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
