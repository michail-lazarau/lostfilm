import Foundation

class SeriesVM: BaseViewModel<TVSeriesOverviewDC, VMseriesItem>, ILoadingHeterogeneousItems {
    typealias ModelType = LFSeriesModel
    weak var delegate: IUpdatingViewDelegate?
    
    func loadItems() {
        loadItems(dataProvider: dataProvider) {
            self.delegate?.updateTableView()
        }
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
            items.append(VMseriesDetailRatingIMDbItem(ratingIMDb: model.ratingIMDb))
        }
        
        if let genre = model.genres {
            let genreItem = VMseriesDetailGenreItem(genre: genre)
            items.append(genreItem)
        }
        
        if let type = model.type {
            let typeItem = VMseriesDetailTypeItem(type: type)
            items.append(typeItem)
        }
        
        if let officialSiteUrl = model.officialSiteURL {
            let officialSiteItem = VMseriesDetailOfficialSiteItem(officialSiteUrl: officialSiteUrl)
            items.append(officialSiteItem)
        }
        
        if let seriesDescription = model.seriesDescription {
            let seriesDescriptionItem = VMseriesDescriptionItem(seriesDescription: seriesDescription)
            items.append(seriesDescriptionItem)
        }
    }
}
