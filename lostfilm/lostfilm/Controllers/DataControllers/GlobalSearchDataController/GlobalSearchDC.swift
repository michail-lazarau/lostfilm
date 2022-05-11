import Foundation

class GlobalSearchDC {
    var delegate: DelegateGlobalSearchDC?
    var seriesList: [LFSeriesModel]?
    var personList: [LFPersonModel]?
    
    func getGlobalSearchOutputFor(searchContext: String) {
        getGlobalSearchOutputFor(searchContext: searchContext) { [weak self] seriesList, personList, _ in
            guard let strongSelf = self else {
                return
            }
            strongSelf.seriesList = seriesList
            strongSelf.personList = personList
            
            DispatchQueue.main.async {
                //
            }
        }
    }
    
    private func getGlobalSearchOutputFor(searchContext: String, completionHandler: @escaping ([LFSeriesModel]?, [LFPersonModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
        apiHelper.series.getGlobalSearchOutput(forContext: searchContext, withCompletionHandler: { seriesList, personList, error in
            completionHandler(seriesList, personList, error as NSError?)
        })
    }
}
