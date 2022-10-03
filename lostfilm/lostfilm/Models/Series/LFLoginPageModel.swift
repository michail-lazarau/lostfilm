import Foundation

class LFLoginPageModel: LFJsonObject {
    let captchaIsRequired: Bool
    let captchaUrl: URL

    override init(data: [AnyHashable: Any]) {
        let captchaStyleDisplay = (data as NSDictionary).ac_string(forKey: Property.captchaStyleDisplay.stringValue)

        captchaIsRequired = captchaStyleDisplay == nil // MARK: the value is either "display:none" or nil

        captchaUrl = (data as NSDictionary).ac_url(forKey: Property.captchaUrl.stringValue)
        super.init(data: data)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    enum Property: String, CodingKey {
        case captchaStyleDisplay, captchaUrl
    }

    override func isEqual(_ object: Any?) -> Bool {
        var isEqual = false
        if let object = object as? LFLoginPageModel {
            isEqual = captchaIsRequired == object.captchaIsRequired && captchaUrl == object.captchaUrl
        }
        return isEqual
    }
}
