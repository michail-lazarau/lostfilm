import Foundation
@testable import lostfilm

class MockGlobalSearchDC: NSObject, GlobalSearchProtocol {
    @objc dynamic var delegate: IUpdatingViewDelegate? = MockGlobalSearchTVC()
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

    func getGlobalSearchOutputFor(searchContext: String, completionHandler: @escaping ([LFSeriesModel]?, [LFPersonModel]?, NSError?) -> Void) {
        searchContext == "Lost"
        ? completionHandler([TestDataObject.seriesModel], [TestDataObject.personModel], nil)
        : completionHandler(nil, nil, NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotFindHost))
    }

    func didEmptySearchResults() {
        seriesList = nil
        personList = nil
    }
}
