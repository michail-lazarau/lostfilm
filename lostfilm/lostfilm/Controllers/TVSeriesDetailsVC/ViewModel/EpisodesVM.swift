import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class EpisodesVM: NSObject {
    var items = [VMepisodeItem]()
    var dataProvider: TVSeriesEpisodesDC?
    
    override init() {
        super.init()
    }
    
    init(dataProvider: TVSeriesEpisodesDC) {
        super.init()
        self.dataProvider = dataProvider
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
