import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class SeriesVM: NSObject {
    var itemList = [VMseriesItem]() // sections for the UITableView

    override init() {
        super.init()
    }
    
    init(model: LFSeriesModel) {
        super.init()
        
        if let posterUrl = model.posterURL{
            let posterItem = VMseriesPosterItem(posterUrl: posterUrl, rating: model.rating)
            itemList.append(posterItem)
        }
        
        if let premiereDate = model.premiereDate {
            let premiereDateItem = VMseriesDetailPremiereDateItem(premiereDate: premiereDate)
            itemList.append(premiereDateItem)
        }
        
        if let channel = model.channels, let country = model.country {
            let channelCountryItem = VMseriesDetailChannelCountryItem(channels: channel, country: country)
            itemList.append(channelCountryItem)
        }
        
        if(model.ratingIMDb > 0.0) {
            itemList.append(SeriesVMdetailRatingIMDbItem(ratingIMDb: model.ratingIMDb))
        }
        
        if let genre = model.genres {
            let genreItem = SeriesVMdetailGenreItem(genre: genre)
            itemList.append(genreItem)
        }
        
        if let type = model.type {
            let typeItem = SeriesVMdetailTypeItem(type: type)
            itemList.append(typeItem)
        }
        
        if let officialSiteUrl = model.officialSiteURL {
            let officialSiteItem = SeriesVMdetailOfficialSiteItem(officialSiteUrl: officialSiteUrl)
            itemList.append(officialSiteItem)
        }
        
        if let seriesDescription = model.seriesDescription {
            let seriesDescriptionItem = SeriesVMseriesDescriptionItem(seriesDescription: seriesDescription)
            itemList.append(seriesDescriptionItem)
        }
    }
}
