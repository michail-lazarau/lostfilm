import Foundation

public enum FilteringEnum: Int, CustomStringConvertible {
    case Sorting, Status, Genre, ReleaseYear, Channel, Types
    
    public var description: String {
        switch self.rawValue {
        case 0: return "Сортировать"
        case 1: return "Статус"
        case 2: return "Жанр"
        case 3: return "Год выхода"
        case 4: return "Канал"
        case 5: return "Тип"
        default: return "Error"
        }
    }
    // https://stackoverflow.com/questions/28461133/swift-enum-both-a-string-and-an-int
}
