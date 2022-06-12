import Foundation

enum GlobalSearchItemType: CaseIterable {
    case series
    case persons
    
    var description: String {
        switch self {
        case .series: return "Сериалы"
        case .persons: return "Люди"
        }
    }
}
