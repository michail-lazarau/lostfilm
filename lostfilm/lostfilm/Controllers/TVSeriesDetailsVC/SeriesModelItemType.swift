import Foundation

enum SeriesModelItemType: String, CaseIterable {
    case detailPremiereDate = "Премьера:"
    case detailChannelCountry = "Канал, Страна:"
    case detailRatingIMDb = "Рейтинг IMDb:"
    case detailGenre = "Жанр:"
    case detailType = "Тип:"
    case detailOfficialSite = "Официальный сайт:"
    case poster = ""
    case description = "Описание"
}
