import Foundation

enum DVHtmlError: LocalizedError {
    case failedToParseCaptchaElement, failedToLoadOnUrl

    public var errorDescription: String? {
        switch self {
        case .failedToParseCaptchaElement: return "Captcha was not found in DOM"
        case .failedToLoadOnUrl: return "Unable to load the resource"
        }
    }
}
