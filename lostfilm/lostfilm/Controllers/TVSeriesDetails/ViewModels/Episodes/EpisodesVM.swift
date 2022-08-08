import Foundation

class EpisodesVM: BaseViewModel<TVSeriesEpisodesDC, VMepisodeItem>, ILoadingHeterogeneousItems {
    weak var delegate: IUpdatingViewDelegate?
    
    func loadItems() {
        loadItems(dataProvider: dataProvider) {
            self.delegate?.updateTableView()
        }
    }
    
    func setupVMwith(model: [LFSeasonModel]) {
        for season in model {
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
