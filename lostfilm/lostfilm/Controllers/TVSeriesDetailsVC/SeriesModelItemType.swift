import Foundation

enum SeriesModelItemType: String, CaseIterable {
    case detailPremiereDate
    case detailChannelCountry
    case detailRatingIMDb
    case detailGenre
    case detailType
    case detailOfficialSite
    case poster
    case description
    
    var description: String {
        switch self {
        case .detailPremiereDate: return "Премьера:"
        case .detailChannelCountry: return "Канал, Страна:"
        case .detailRatingIMDb: return "Рейтинг IMDb:"
        case .detailGenre: return "Жанр:"
        case .detailType: return "Тип:"
        case .detailOfficialSite: return "Официальный сайт:"
        case .description: return "Описание"
        case .poster: return ""
        }
    }
}
