import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class SeriesVM: NSObject {
    var items = [VMseriesItem]() // sections for the UITableView
    var dataProvider: TVSeriesOverviewDC?

    override init() {
        super.init()
    }
    
    init(dataProvider: TVSeriesOverviewDC) {
        super.init()
        self.dataProvider = dataProvider
    }
    
    func setupVMwith(model: LFSeriesModel) {
        if let posterUrl = model.posterURL{
            let posterItem = VMseriesPosterItem(posterUrl: posterUrl, rating: model.rating)
            items.append(posterItem)
        }
        
        if let premiereDate = model.premiereDate {
            let premiereDateItem = VMseriesDetailPremiereDateItem(premiereDate: premiereDate)
            items.append(premiereDateItem)
        }
        
        if let channel = model.channels, let country = model.country {
            let channelCountryItem = VMseriesDetailChannelCountryItem(channels: channel, country: country)
            items.append(channelCountryItem)
        }
        
        if(model.ratingIMDb > 0.0) {
            items.append(SeriesVMdetailRatingIMDbItem(ratingIMDb: model.ratingIMDb))
        }
        
        if let genre = model.genres {
            let genreItem = SeriesVMdetailGenreItem(genre: genre)
            items.append(genreItem)
        }
        
        if let type = model.type {
            let typeItem = SeriesVMdetailTypeItem(type: type)
            items.append(typeItem)
        }
        
        if let officialSiteUrl = model.officialSiteURL {
            let officialSiteItem = SeriesVMdetailOfficialSiteItem(officialSiteUrl: officialSiteUrl)
            items.append(officialSiteItem)
        }
        
        if let seriesDescription = model.seriesDescription {
            let seriesDescriptionItem = SeriesVMseriesDescriptionItem(seriesDescription: seriesDescription)
            items.append(seriesDescriptionItem)
        }
    }
}
