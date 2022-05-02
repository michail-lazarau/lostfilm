import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class EpisodesVM: NSObject {
    var items = [VMepisodeItem]() // number of elements are equal to the number of seasons
    var dataProvider: TVSeriesEpisodesDC
    
    init(dataProvider: TVSeriesEpisodesDC) {
        self.dataProvider = dataProvider
        super.init()
    }
    
    func setupVMwith(seasonList: [LFSeasonModel]) {
        for season in seasonList {
            if let episodeList = season.episodeList {
                let episodeItem: VMepisodeItem
                
                if let seasonPosterUrl = season.posterURL, let seasonDetails = season.details {
                    episodeItem = VMepisodeItem(episodeList: episodeList, seasonNumber: season.number, seasonPosterUrl: seasonPosterUrl, seasonDetails: seasonDetails)
                } else {
                    episodeItem = VMepisodeItem(episodeList: episodeList, seasonNumber: season.number)
                }
                items.append(episodeItem)
            }
        }
    }
}
