import Foundation

public enum FilterType: String/*,CustomStringConvertible*/ {
    case Sort = "Sort"
    case CustomType = "Type"
    case Genre = "Genre"
    case ReleaseYear = "Release_year"
    case Channel = "Channel"
    case Group = "Group"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

// https://stackoverflow.com/questions/28213693/enum-with-localized-string-in-swift
