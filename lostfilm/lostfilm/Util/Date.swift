import Foundation

extension Date {
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
    
    var dayAfterTomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 2, to: self)!
    }
    
    func getDayOfThisWeek(weekday: Int) -> Date {
        var dateComponents = Calendar.current.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date())
        dateComponents.weekday = weekday
        return Calendar.current.date(from: dateComponents)!
    }
}
