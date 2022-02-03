import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class LFSeriesVM: NSObject {
    var itemList = [LFSeriesVMitem]() // sections for the UITableView

    override init() {
        super.init()
    }
    
    init(model: LFSeriesModel) {
        super.init()
        
        if let posterUrl = model.posterURL{
            let posterItem = LFSeriesVMposterItem(posterUrl: posterUrl, rating: model.rating)
            itemList.append(posterItem)
        }
        
        if let premiereDate = model.premiereDate {
            let premiereDateItem = LFSeriesVMdetailPremiereDateItem(premiereDate: premiereDate)
            itemList.append(premiereDateItem)
        }
        
        if let channel = model.channels, let country = model.country {
            let channelCountryItem = LFSeriesVMdetailChannelCountryItem(channels: channel, country: country)
            itemList.append(channelCountryItem)
        }
        
        if(model.ratingIMDb > 0.0) {
            itemList.append(LFSeriesVMdetailRatingIMDbItem(ratingIMDb: model.ratingIMDb))
        }
        
        if let genre = model.genres {
            let genreItem = LFSeriesVMdetailGenreItem(genre: genre)
            itemList.append(genreItem)
        }
        
        if let type = model.type {
            let typeItem = LFSeriesVMdetailTypeItem(type: type)
            itemList.append(typeItem)
        }
        
        if let officialSiteUrl = model.officialSiteURL {
            let officialSiteItem = LFSeriesVMdetailOfficialSiteItem(officialSiteUrl: officialSiteUrl)
            itemList.append(officialSiteItem)
        }
        
        if let seriesDescription = model.seriesDescription {
            let seriesDescriptionItem = LFSeriesVMseriesDescriptionItem(seriesDescription: seriesDescription)
            itemList.append(seriesDescriptionItem)
        }
    }
}
