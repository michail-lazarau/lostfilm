import Foundation

class UserLoginResponse: Decodable {
    public var name: String?
    public var needCaptcha: Bool?
    public var success: Bool?
    public var result: String?
    public var error: Int?

    private enum CodingKeys: String, CodingKey {
        case name, needCaptcha, success, result, error
    }

    required init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            needCaptcha = try values.decodeIfPresent(Bool.self, forKey: .needCaptcha)
            success = try values.decodeIfPresent(Bool.self, forKey: .success)
            result = try values.decodeIfPresent(String.self, forKey: .result)
            error = try values.decodeIfPresent(Int.self, forKey: .error)
        } catch DecodingError.typeMismatch(let type, let context) {
            throw DecodingError.typeMismatch(type, context)
        } catch _ {
            throw DataTaskError.invalidJSON
        }
    }
}
