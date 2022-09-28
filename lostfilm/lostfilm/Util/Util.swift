import Foundation

func login() {
    let username = "creativemanhorde@gmail.com"
    let password = "unhollylm0106"

    HTTPCookieStorage.shared.removeCookies(since: Date(timeIntervalSince1970: 0))
    LoginService(session: URLSession.shared).login(userLogin: username, password: password) { result in
        switch result {
        case .success:
            break
        case let .failure(error):
            print(error.localizedDescription)
        }
    }
}

func oldLogin() {
    let cookieProperties: [HTTPCookiePropertyKey: Any] = [
        HTTPCookiePropertyKey.name: "lf_session",
        HTTPCookiePropertyKey.value: "70aadc36df10002bd40a6d01d2b567d7.7024831",
        HTTPCookiePropertyKey.domain: ".lostfilm.tv",
        HTTPCookiePropertyKey.path: "/",
        HTTPCookiePropertyKey.expires: Date().addingTimeInterval(10000000),
        HTTPCookiePropertyKey.secure: true
    ]

    HTTPCookieStorage.shared.setCookie(HTTPCookie(properties: cookieProperties)!)
}

func dateToString(date: Date, locale: Locale, dateFormat: String) -> String {
    let formatter = DateFormatter()
    formatter.locale = locale
    formatter.dateFormat = dateFormat
    return formatter.string(from: date)
}

func dateToString(date: Date, dateFormat: String) -> String {
    dateToString(date: date, locale: Locale.current, dateFormat: dateFormat)
}

// MARK: Trash

extension UILabel {
    func retrieveTextHeight() -> CGFloat {
        let attributedText = NSAttributedString(string: text!, attributes: [NSAttributedString.Key.font: font!])

        let rect = attributedText.boundingRect(with: CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(rect.size.height)
    }

    func setMargins(_ margin: CGFloat = 10) {
        if let textString = text {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = margin
            paragraphStyle.headIndent = margin
            paragraphStyle.tailIndent = -margin
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
