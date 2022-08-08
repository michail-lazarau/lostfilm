import Foundation

class ScheduleDataController {
    weak var delegate: IUpdatingViewDelegate?
    private var itemList: [[LFEpisodeModel]] = Array(repeating: [], count: 5)
    private var isLoading: Bool = false
    var sectionsCount: Int {
        itemList.count
    }

    private let sections: [ScheduleDateInterval] = [.today, .tomorrow, .thisWeek, .nextWeek, .later]
    
    func getSchedule() {
        if isLoading == true {
            return
        }
        isLoading = true
        
        getTimeTable { [weak self] episodesList, _ in
            guard let strongSelf = self
            else { return }
            if let episodesList = episodesList {
                var offset = 0
                for section in strongSelf.sections {
                    let dateInterval = strongSelf.makeInterval(dateInterval: section)
                    let slice = episodesList[offset...].prefix { model in
                        dateInterval.contains(model.dateRu)
                    }
                    strongSelf.itemList[section.rawValue] += slice
                    offset += slice.count
                }
            }
            DispatchQueue.main.async {
                if let delegate = strongSelf.delegate {
                    delegate.updateTableView()
                }
            }
            
            strongSelf.isLoading = false
        }
    }

    func getTimeTable(completionHander: @escaping ([LFEpisodeModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.shared
        apiHelper.series.getTimetableWithCompletionHandler { episodesList, error in
            completionHander(episodesList, error as NSError?)
        }
    }

    // https://www.globalnerdy.com/2020/05/28/how-to-work-with-dates-and-times-in-swift-5-part-3-date-arithmetic/
    func makeInterval(dateInterval intervalEnum: ScheduleDateInterval) -> DateInterval {
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let dayAfterTomorrow = Calendar.current.date(byAdding: .day, value: 2, to: today)!
        let sundayOfThisWeek = today.getDay(weekday: 1, weekOffset: 0) // weekday 1 is Sunday
        let mondayOfNextWeek = today.getDay(weekday: 2, weekOffset: 1) // weekday 2 is Monday
        let mondayInFortnight = today.getDay(weekday: 2, weekOffset: 2) // weekday 2 is Monday
        let comparisonOfSundayOfThisWeekTowardsDayAfterTomorrow = Calendar.current.compare(sundayOfThisWeek, to: dayAfterTomorrow, toGranularity: .day)
        let dateIsOnThisWeekAfterTomorrow = comparisonOfSundayOfThisWeekTowardsDayAfterTomorrow == .orderedDescending
        || comparisonOfSundayOfThisWeekTowardsDayAfterTomorrow == .orderedSame
        let dateInterval: DateInterval
        
        switch intervalEnum {
        case .today:
            dateInterval = DateInterval(start: today.startOfDay, end: today.endOfDay)
        case .tomorrow:
            dateInterval = DateInterval(start: tomorrow.startOfDay, end: tomorrow.endOfDay)
        case .thisWeek where dateIsOnThisWeekAfterTomorrow :
            dateInterval = DateInterval(start: dayAfterTomorrow.startOfDay, end: sundayOfThisWeek.endOfDay)
        case .nextWeek:
            dateInterval = DateInterval(start: mondayOfNextWeek.startOfDay, duration: 604800 - 1)
        case .later:
            dateInterval = DateInterval(start: mondayInFortnight.startOfDay, duration: 31536000)
        default:
            dateInterval = DateInterval()
        }
        return dateInterval
    }
    
    func DidEmptyItemList() {
        itemList.removeAll()
        itemList = Array(repeating: [], count: 5)
    }
}

extension ScheduleDataController {
    subscript(section: Int, model: Int) -> LFEpisodeModel {
        itemList[section][model]
    }

    subscript(section: Int) -> [LFEpisodeModel] {
        itemList[section]
    }
}
