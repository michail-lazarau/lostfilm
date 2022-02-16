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
    
    func setupVMwith(modelList: [LFSeasonModel]) {
        for model in modelList {
            if let episodeList = model.episodeList {
                let episodeItem = VMepisodeItem(episodeList: episodeList)
                items.append(episodeItem)
            }
        }
    }
}
