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
            let episodeItem = VMepisodeItem(episodeList: model.episodeList)
            items.append(episodeItem)
        }
    }
}
