import Foundation

class GlobalSearchDC: GlobalSearchProtocol {
    weak var delegate: IUpdatingViewDelegate?
    var seriesList: [LFSeriesModel]?
    var personList: [LFPersonModel]?
    
    func getGlobalSearchOutputFor(searchContext: String) {
        getGlobalSearchOutputFor(searchContext: searchContext) { [weak self] seriesList, personList, error in
            guard let strongSelf = self else {
                return
            }
            strongSelf.seriesList = seriesList
            strongSelf.personList = personList
            // FIXME: an error is caught when the output is out of records. Hence the datasource is not updated
            if error == nil {
                DispatchQueue.main.async {
                    strongSelf.delegate?.updateTableView()
                }
            }
        }
    }
    
    func didEmptySearchResults() {
        seriesList = nil
        personList = nil
    }
    
    func getGlobalSearchOutputFor(searchContext: String, completionHandler: @escaping ([LFSeriesModel]?, [LFPersonModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.shared
        apiHelper.series.getGlobalSearchOutput(forContext: searchContext, withCompletionHandler: { seriesList, personList, error in
            completionHandler(seriesList, personList, error as NSError?)
        })
    }
}

protocol GlobalSearchProtocol {
    func getGlobalSearchOutputFor(searchContext: String)
    func getGlobalSearchOutputFor(searchContext: String, completionHandler: @escaping ([LFSeriesModel]?, [LFPersonModel]?, NSError?) -> Void)
    func didEmptySearchResults()
}
