import Foundation

func dateToString(date: Date, locale: Locale, dateFormat: String) -> String {
    let formatter = DateFormatter()
    formatter.locale = locale
    formatter.dateFormat = dateFormat
    return formatter.string(from: date)
}

func dateToString(date: Date, dateFormat: String) -> String {
    dateToString(date: date, locale: Locale(identifier: "en_US"), dateFormat: dateFormat)
}

extension UILabel {

    func retrieveTextHeight () -> CGFloat {
        let attributedText = NSAttributedString(string: self.text!, attributes: [NSAttributedString.Key.font:self.font])

        let rect = attributedText.boundingRect(with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(rect.size.height)
    }

    func setMargins(_ margin: CGFloat = 10) {
        if let textString = self.text {
            var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = margin
            paragraphStyle.headIndent = margin
            paragraphStyle.tailIndent = -margin
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
