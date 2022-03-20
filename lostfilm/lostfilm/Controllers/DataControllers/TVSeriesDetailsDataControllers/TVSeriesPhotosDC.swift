import Foundation

class TVSeriesPhotosDC {
    private var isLoading: Bool = false
    var currentPage: UInt = 0
    var delegate: DelegateTVSeriesDCwithPagination?
    let tvSeries: LFSeriesModel // MARK: or ViewModel instead? VMseriesItem has no id yet // MARK: make weak?
    var photoList: [LFPhotoModel] = []
    
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
        getPhotoListForSeriesBy(seriesId: tvSeries.id, pageNumber: page) { [weak self] photoList, _ in
            guard let strongSelf = self, let photoList = photoList else {
                return
            }
            strongSelf.photoList += photoList
            
            DispatchQueue.main.async {
                if strongSelf.currentPage > 1 {
                    let indexPathToReload = strongSelf.calculateIndexPathsToReload(from: photoList)
                    strongSelf.delegate?.updateTableView(with: indexPathToReload)
                } else {
                    strongSelf.delegate?.updateTableView(with: .none)
                }
            }
            strongSelf.isLoading = false
        }
    }
    
    private func getPhotoListForSeriesBy(seriesId: String, pageNumber: UInt, completionHandler: @escaping ([LFPhotoModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getPhotoListForSeries(byId: seriesId, page: pageNumber) { photoList, error in
            completionHandler(photoList, error as NSError?)
        }
    }
    
    private func calculateIndexPathsToReload(from newPhotoList: [LFPhotoModel]) -> [IndexPath] {
      let startIndex = photoList.count - newPhotoList.count
      let endIndex = startIndex + newPhotoList.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func didEmptyNewsList() {
        photoList.removeAll()
        currentPage = 0
    }
}
