import Foundation

final class TVSeriesEpisodesDC: TVSeriesDetailsAbstractNonPaginatingDC<[LFSeasonModel]> {
    override func getItemListForSeriesBy(seriesId: String, completionHandler: @escaping ([LFSeasonModel]?, NSError?) -> Void) {
        let apiHelper: LFApiSeries = LFApplicationHelper.sharedApiHelper.series
        apiHelper.getSeriesGuideForSeries(byId: seriesId, completionHandler: { seasonList, error in
            completionHandler(seasonList, error as NSError?)
        })
    }
}
