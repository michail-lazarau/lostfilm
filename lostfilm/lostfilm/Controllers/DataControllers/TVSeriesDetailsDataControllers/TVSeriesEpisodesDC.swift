import Foundation

class TVSeriesEpisodesDC {
    var delegate: DelegateTVSeriesOverviewDC?
    let series: LFSeriesModel // MARK: or ViewModel instead? VMseriesItem has no id yet // MARK: make weak?
    var modelList: [LFSeasonModel] = []
    
    init(model: LFSeriesModel) {
        self.series = model
    }
    
    func getSeriesGuide() {
        getSeriesGuideForSeriesBy(seriesId: series.id) { [weak self] seasonList, _ in
            guard let strongSelf = self, let seasonList = seasonList else {
                return
            }
            strongSelf.modelList = seasonList
            DispatchQueue.main.async {
                strongSelf.delegate?.updateTableView()
            }
        }
    }
    
    private func getSeriesGuideForSeriesBy(seriesId: String, completionHander: @escaping ([LFSeasonModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getSeriesGuideForSeries(byId: seriesId, completionHandler: { seasonList, error in
            completionHander(seasonList, error as NSError?)
        })
    }
}
