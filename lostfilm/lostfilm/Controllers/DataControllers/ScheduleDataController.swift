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
}

extension ScheduleDataController {
    subscript(index: Int) -> LFEpisodeModel {
        itemList[index]
    }
}
