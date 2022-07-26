import Foundation

class TVSeriesEpisodesDC {
    var delegate: DelegateTVSeriesDetailsDC?
    let tvSeriesModel: LFSeriesModel // MARK: or ViewModel instead? VMseriesItem has no id yet // MARK: make weak?
    var seasonList: [LFSeasonModel] = []
    
    init(model: LFSeriesModel) {
        self.tvSeriesModel = model
    }
    
    func getSeriesGuide() {
        getSeriesGuideForSeriesBy(seriesId: tvSeriesModel.id) { [weak self] seasonList, _ in
            guard let strongSelf = self, let seasonList = seasonList else {
                return
            }
            strongSelf.seasonList = seasonList
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
