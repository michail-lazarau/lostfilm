import Foundation

class TVSeriesOverviewDC {
    var delegate: DelegateTVSeriesOverviewDC?
    var model: LFSeriesModel // MARK: or ViewModel instead? VMseriesItem has no id yet // MARK: make weak?
    
    init(model: LFSeriesModel) {
        self.model = model
    }
    
    func getDetails() {
        getDetailsForSeriesBy(seriesId: model.id) { [weak self] seriesModel, _ in
            guard let strongSelf = self, let seriesModel = seriesModel else {
                return
            }
            strongSelf.model = seriesModel
            DispatchQueue.main.async {
                strongSelf.delegate?.updateTableView()
            }
        }
    }
    
    private func getDetailsForSeriesBy(seriesId: String, completionHander: @escaping (LFSeriesModel?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getDetailsForSeries(byId: seriesId, completionHandler: { seriesModel, error in
            completionHander(seriesModel, error as NSError?)
        })
    }
}
