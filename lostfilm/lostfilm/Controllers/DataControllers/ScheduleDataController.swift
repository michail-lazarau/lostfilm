import Foundation

class ScheduleDataController {
    var delegate: ScheduleDataControllerDelegate?
    private var itemList: [LFEpisodeModel] = []
    private var isLoading: Bool = false
    var count: Int {
        itemList.count
    }
//    override func getItemListForPage(number: UInt, completionHander: @escaping ([LFEpisodeModel]?, NSError?) -> Void) {
//        let apiHelper = LFApplicationHelper.sharedApiHelper
//        apiHelper.series.getTimetableWithCompletionHandler { episodesList, error in
//            completionHander(episodesList, error as NSError?)
//        }

//    func getSchedule() {
//        if isLoading == true {
//            return
//        }
//        isLoading = true
//
//        let apiHelper = LFApplicationHelper.sharedApiHelper
//        apiHelper.series.getTimetableWithCompletionHandler { [weak self] episodesList, _ in
//            guard let strongSelf = self
//            else { return }
//
//            strongSelf.itemList = episodesList ?? []
//            DispatchQueue.main.async {
//                if let delegate = self?.delegate { // FIXME: strongSelf instead of self?
//                    delegate.updateUIForTimeTable()
//                }
//            }
//            strongSelf.isLoading = false
//        }
//    }
    
    func getSchedule() {
        
        getTimeTable { [weak self] episodesList, _ in
            guard let strongSelf = self
            else { return }
            
            strongSelf.itemList = episodesList ?? []
            DispatchQueue.main.async {
                if let delegate = self?.delegate { // FIXME: strongSelf instead of self?
                    delegate.updateUIForTimeTable()
                }
            }
        }
    }
    
    func getTimeTable(completionHander: @escaping ([LFEpisodeModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getTimetableWithCompletionHandler { newsList, error in
            completionHander(newsList, error as NSError?)
        }
    }
    
    func selectItemsWithin(dateInterval intervalEnum: ScheduleDateInterval) -> ArraySlice<LFEpisodeModel> {
        let today = Date()
        let dateInterval: DateInterval
//        Calendar.current.locale = Locale(identifier: "ru_RU")
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        calendar.timeZone = .current
        var dateComponents = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: today)
        
        switch intervalEnum {
        case .today:
            dateInterval = DateInterval(start: today.startOfDay, end: today.startOfDay)
        case .tomorrow:
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
            dateInterval = DateInterval(start: tomorrow.startOfDay, end: tomorrow.endOfDay)
        case .thisWeek:
            dateComponents.weekday = 1 // Sunday
            let dayOfThisWeek = calendar.date(from: dateComponents)!
            let dayAfterTomorrow = today.dayAfterTomorrow
            if(dayAfterTomorrow <= dayOfThisWeek) {
                dateInterval = DateInterval(start: today.dayAfterTomorrow, end: dayOfThisWeek)
            } else {
                return ArraySlice<LFEpisodeModel>()
            }
        case .nextWeek:
            dateComponents.weekday = 2 // Monday
            let dayOfThisWeek = calendar.date(from: dateComponents)!
            let nextWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: dayOfThisWeek)!
            dateInterval = DateInterval(start: nextWeek, duration: 604800 - 1)
        case .later:
            dateComponents.weekday = 2 // Monday
            let dayOfThisWeek = calendar.date(from: dateComponents)!
            let fortnight = calendar.date(byAdding: .weekOfYear, value: 2, to: dayOfThisWeek)!
            dateInterval = DateInterval(start: fortnight, duration: 31536000)
        }
        return itemList.prefix { model in
            dateInterval.contains(model.dateRu)
        }
    }
}

extension ScheduleDataController {
    subscript(index: Int) -> LFEpisodeModel {
        itemList[index]
    }
}
