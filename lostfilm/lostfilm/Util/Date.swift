import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }

    func getDay(weekday: Int, weekOffset: Int) -> Date {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        var dateComponents = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        dateComponents.weekday = weekday
        let day = calendar.date(from: dateComponents)!
        return calendar.date(byAdding: .weekOfYear, value: weekOffset, to: day)!
    }
}
