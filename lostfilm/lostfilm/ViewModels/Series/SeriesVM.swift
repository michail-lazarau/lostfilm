import Foundation

final class SeriesVM: BaseViewModel<TVSeriesOverviewDataProvider, VMseriesItem>, ILoadingDataOnce {
    weak var delegate: IUpdatingViewDelegate?

    func loadItems() {
        loadItems(dataProvider: dataProvider) { [weak self] in
            self?.delegate?.updateView()
        }
    }

    func prepareDataModelForUse(_ dataModel: LFSeriesModel) {
        if let posterUrl = dataModel.posterURL {
            let posterItem = VMseriesPosterItem(posterUrl: posterUrl, rating: dataModel.rating)
            items.append(posterItem)
        }

        if let premiereDate = dataModel.premiereDate {
            let premiereDateItem = VMseriesDetailPremiereDateItem(premiereDate: premiereDate)
            items.append(premiereDateItem)
        }

        if let channel = dataModel.channels, let country = dataModel.country {
            let channelCountryItem = VMseriesDetailChannelCountryItem(channels: channel, country: country)
            items.append(channelCountryItem)
        }

        if dataModel.ratingIMDb > 0.0 {
            items.append(VMseriesDetailRatingIMDbItem(ratingIMDb: dataModel.ratingIMDb))
        }

        if let genre = dataModel.genres {
            let genreItem = VMseriesDetailGenreItem(genre: genre)
            items.append(genreItem)
        }

        if let type = dataModel.type {
            let typeItem = VMseriesDetailTypeItem(type: type)
            items.append(typeItem)
        }

        if let officialSiteUrl = dataModel.officialSiteURL {
            let officialSiteItem = VMseriesDetailOfficialSiteItem(officialSiteUrl: officialSiteUrl)
            items.append(officialSiteItem)
        }

        if let seriesDescription = dataModel.seriesDescription {
            let seriesDescriptionItem = VMseriesDescriptionItem(seriesDescription: seriesDescription)
            items.append(seriesDescriptionItem)
        }
    }
}
