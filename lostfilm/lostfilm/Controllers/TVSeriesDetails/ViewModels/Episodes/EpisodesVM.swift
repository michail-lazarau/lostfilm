import Foundation

class EpisodesVM: BaseViewModel<TVSeriesEpisodesDC, VMepisodeItem>, ILoadingHeterogeneousItemsAllAtOnce {
    weak var delegate: IUpdatingViewDelegate?
    
    func loadItems() {
        loadItems(dataProvider: dataProvider) { [weak self] in
            self?.delegate?.updateTableView()
        }
    }
    
    func splitDataModelToItems(_ dataModel: [LFSeasonModel]) {
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
