import Foundation

public enum LFSeriesFilterModelPropertyEnum: String {
    case Sort = "Sort"
    case CustomType = "Type"
    case Genre = "Genre"
    case ReleaseYear = "Release year"
    case Channel = "Channel"
    case Groups = "Groups"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    static func getTitleFor(title: LFSeriesFilterModelPropertyEnum) -> String {
        return title.localizedString()
    }
}

// https://stackoverflow.com/questions/28213693/enum-with-localized-string-in-swift
