import Foundation

class TVSeriesNewsDC {
    private var isLoading: Bool = false
    var currentPage: UInt = 0
    var delegate: DelegateTVSeriesNewsDC?
    let tvSeries: LFSeriesModel // MARK: or ViewModel instead? VMseriesItem has no id yet // MARK: make weak?
    var newsList: [LFNewsModel] = []
    
    init(model: LFSeriesModel) {
        self.tvSeries = model
    }
    
    func loadDataByPage() {
        if isLoading == true {
            return
        }
        isLoading = true
        currentPage += 1
        getDetailsFor(page: currentPage)
    }
    
    private func getDetailsFor(page: UInt) {
        getNewsListForSeriesBy(seriesId: tvSeries.id, pageNumber: page) { [weak self] newsList, _ in
            guard let strongSelf = self, let newsList = newsList else {
                return
            }
            strongSelf.newsList += newsList
            
            DispatchQueue.main.async {
                if strongSelf.currentPage > 1 {
                    let indexPathToReload = strongSelf.calculateIndexPathsToReload(from: newsList)
                    strongSelf.delegate?.updateTableView(with: indexPathToReload)
                } else {
                    strongSelf.delegate?.updateTableView(with: .none)
                }
            }
            strongSelf.isLoading = false
        }
    }
    
    private func getNewsListForSeriesBy(seriesId: String, pageNumber: UInt, completionHandler: @escaping ([LFNewsModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getNewsListForSeries(byId: seriesId, page: pageNumber) { newsList, error in
            completionHandler(newsList, error as NSError?)
        }
    }
    
    private func calculateIndexPathsToReload(from newNewsList: [LFNewsModel]) -> [IndexPath] {
      let startIndex = newsList.count - newNewsList.count
      let endIndex = startIndex + newNewsList.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func didEmptyNewsList() {
        newsList.removeAll()
        currentPage = 0
    }
}
