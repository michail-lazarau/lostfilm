import Foundation

class TVSeriesNewsDC {
    private var currentPage: UInt = 0
    private var isLoading: Bool = false
    var delegate: DelegateTVSeriesDetailsDC?
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
                strongSelf.delegate?.updateTableView()
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
}
