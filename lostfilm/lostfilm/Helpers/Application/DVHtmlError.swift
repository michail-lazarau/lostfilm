import Foundation

enum DVHtmlError: LocalizedError {
    case failedToParseWebElement, failedToLoadOnUrl
    
    public var errorDescription: String? {
        switch self {
        case .failedToParseWebElement: return "Element was not found in DOM"
        case .failedToLoadOnUrl: return "Unable to load the resource"
        }
    }
}
