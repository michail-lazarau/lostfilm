import Foundation

class VMepisodeItem {
    var rowCount: Int {
        return episodeList.count
    }
    
    var episodeList: [LFEpisodeModel]
    
    init(episodeList: [LFEpisodeModel]) {
        self.episodeList = episodeList
    }
}
