import Foundation

class TVSeriesVideosDC {
    private var isLoading: Bool = false
    var currentPage: UInt = 0
    var delegate: DelegateTVSeriesDCwithPagination?
    let tvSeries: LFSeriesModel // MARK: or ViewModel instead? VMseriesItem has no id yet // MARK: make weak?
    var videoList: [LFVideoModel] = []
    
    init(model: LFSeriesModel) {
        self.tvSeries = model
    }
    
    func loadItemsByPage() {
        if isLoading == true {
            return
        }
        isLoading = true
        currentPage += 1
        getDetailsFor(page: currentPage)
    }
    
    private func getDetailsFor(page: UInt) {
        getVideoListForSeriesBy(seriesId: tvSeries.id, pageNumber: page) { [weak self] videoList, _ in
            guard let strongSelf = self, let videoList = videoList else {
                return
            }
            strongSelf.videoList += videoList
            
            DispatchQueue.main.async {
                if strongSelf.currentPage > 1 {
                    let indexPathToReload = strongSelf.calculateIndexPathsToReload(from: videoList)
                    strongSelf.delegate?.updateTableView(with: indexPathToReload)
                } else {
                    strongSelf.delegate?.updateTableView(with: .none)
                }
            }
            strongSelf.isLoading = false
        }
    }
    
    func didEmptyNewsList() {
        videoList.removeAll()
        currentPage = 0
    }
    
    private func getVideoListForSeriesBy(seriesId: String, pageNumber: UInt, completionHander: @escaping ([LFVideoModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getVideoListForSeries(byId: seriesId, page: pageNumber) { videoList, error in
            completionHander(videoList, error as NSError?)
        }
    }
    
    private func calculateIndexPathsToReload(from newVideoList: [LFVideoModel]) -> [IndexPath] {
      let startIndex = videoList.count - newVideoList.count
      let endIndex = startIndex + newVideoList.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
