import Foundation

struct LoginResponseMock {
    let body: LoginResponseBodyMock?
    let error: Error?
}

enum LoginResponseBodyMock {
    case success
    case fail(type: FailType)

    var data: Data {
        Data(jsonString.utf8)
    }

    var jsonString: String {
        switch self {
        case .success:
            return """
            {
                "name":"Michail Lazarev",
                "success":true,
                "result":"ok"
            }
            """
        case .fail(type: .needCaptcha):
            return """
            {
                "need_captcha":true,
                "result":"ok"
            }
            """
        case .fail(type: .invalidCredentials):
            return """
            {
                "error": 3,
                "result":"ok"
            }
            """
        case .fail(type: .genericOne):
            return """
            {
                "error": 1,
                "result":"ok"
            }
            """
        case .fail(type: .invalidCaptcha):
            return """
            {
                "error": 4,
                "result":"ok"
            }
            """
        case .fail(type: .undecodable):
            return "[]"
        }
    }

    enum FailType {
        case invalidCredentials
        case needCaptcha
        case genericOne
        case invalidCaptcha
        case undecodable
    }
}
