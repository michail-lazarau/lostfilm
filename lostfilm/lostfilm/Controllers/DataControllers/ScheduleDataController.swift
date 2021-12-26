import Foundation

class ScheduleDataController {
    var delegate: ScheduleDataControllerDelegate?
    private var itemList: [LFEpisodeModel] = []
    private var isLoading: Bool = false
    var count: Int {
        itemList.count
    }
    private var offset: Int = 0
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
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let dayAfterTomorrow = Calendar.current.date(byAdding: .day, value: 2, to: today)!
        let sundayOfThisWeek = today.getDay(weekday: 1, weekOffset: 0) // weekday 1 is Sunday
        let mondayOfNextWeek = today.getDay(weekday: 2, weekOffset: 1) // weekday 2 is Monday
        let mondayInFortnight = today.getDay(weekday: 2, weekOffset: 2) // weekday 2 is Monday
        let dateInterval: DateInterval
        
        switch intervalEnum {
        case .today:
            dateInterval = DateInterval(start: today.startOfDay, end: today.startOfDay)
        case .tomorrow:
            dateInterval = DateInterval(start: tomorrow.startOfDay, end: tomorrow.endOfDay)
        case .thisWeek where sundayOfThisWeek >= dayAfterTomorrow:
            dateInterval = DateInterval(start: dayAfterTomorrow.startOfDay, end: sundayOfThisWeek.endOfDay)
        case .nextWeek:
            dateInterval = DateInterval(start: mondayOfNextWeek.startOfDay, duration: 604800 - 1)
        case .later:
            dateInterval = DateInterval(start: mondayInFortnight.startOfDay, duration: 31536000)
        default:
            dateInterval = DateInterval()
        }
        let slice = itemList[offset...].prefix { model in
            dateInterval.contains(model.dateRu)
        }
        offset += slice.count
        return slice
    }
}

extension ScheduleDataController {
    subscript(index: Int) -> LFEpisodeModel {
        itemList[index]
    }
}
