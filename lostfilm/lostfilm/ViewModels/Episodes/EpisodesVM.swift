import Foundation

final class EpisodesVM: BaseViewModel<TVSeriesEpisodesDataProvider, VMepisodeItem>, ILoadingDataOnce {
    weak var delegate: IUpdatingViewDelegate?

    func loadItems() {
        loadItems(dataProvider: dataProvider) { [weak self] in
            self?.delegate?.updateView()
        }
    }

    func prepareDataModelForUse(_ dataModel: [LFSeasonModel]) {
        for season in dataModel {
            let episodeItem: VMepisodeItem
            if let seasonPosterUrl = season.posterURL, let seasonDetails = season.details {
                episodeItem = VMepisodeItem(episodeList: season.episodeList, seasonNumber: season.number, seasonPosterUrl: seasonPosterUrl, seasonDetails: seasonDetails)
            } else {
                episodeItem = VMepisodeItem(episodeList: season.episodeList, seasonNumber: season.number)
            }
            items.append(episodeItem)
        }
    }
}
