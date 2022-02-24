import Foundation

class VMepisodeItem {
    var rowCount: Int {
        return episodeList.count
    }
    
    var seasonNumber: String
    var seasonPosterUrl: URL?
    var seasonDetails: String?
    var episodeList: [LFEpisodeModel]
    
    required init(episodeList: [LFEpisodeModel], seasonNumber: UInt) {
        self.episodeList = episodeList
        self.seasonNumber = "\(seasonNumber) сезон"
    }
    
    convenience init(episodeList: [LFEpisodeModel], seasonNumber: UInt, seasonPosterUrl: URL?, seasonDetails: String?) {
        self.init(episodeList: episodeList, seasonNumber: seasonNumber)
        self.seasonPosterUrl = seasonPosterUrl
        self.seasonDetails = seasonDetails
    }
}
