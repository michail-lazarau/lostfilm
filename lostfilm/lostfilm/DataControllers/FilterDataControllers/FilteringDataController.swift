import Foundation

class FilteringDataController {
    internal var filtersModel: LFSeriesFilterModel?

    func getFilters() {
        getSeriesFilter { [weak self] filtersList, _ in
            guard let strongSelf = self
            else { return }
            strongSelf.filtersModel = filtersList

//            DispatchQueue.main.async {
//                if let delegate = strongSelf.delegate {
//                    delegate.func()
//                }
//            }
        }
    }

    func getSeriesFilter(completionHander: @escaping (LFSeriesFilterModel?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.shared
        apiHelper.series.getListsFilter { filtersList, error in
            completionHander(filtersList, error as NSError?)
        }
    }
}
