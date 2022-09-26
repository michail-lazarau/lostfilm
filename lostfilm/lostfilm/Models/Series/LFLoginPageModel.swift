import Foundation

class LFLoginPageModel: LFJsonObject {
    let captchaIsRequired: Bool
    let captchaUrl: URL
    
    override init(data: [AnyHashable : Any]) {
        let captchaStyleDisplay = (data as NSDictionary).ac_string(forKey: Property.captchaStyleDisplay.stringValue)
        self.captchaIsRequired = captchaStyleDisplay == nil // MARK: false when style is "display:none"
        captchaUrl = (data as NSDictionary).ac_url(forKey: Property.captchaUrl.stringValue)
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Property: String, CodingKey {
        case captchaStyleDisplay, captchaUrl
    }
}
