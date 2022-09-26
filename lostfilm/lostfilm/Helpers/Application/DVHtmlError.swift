import Foundation

enum DVHtmlError: LocalizedError {
    case failedToParseWebElement, failedToLoadDOM
    
    public var errorDescription: String? {
        switch self {
        case .failedToParseWebElement: return "Element was not found in DOM"
        case .failedToLoadDOM: return "Target page was not loaded"
        }
    }
}
