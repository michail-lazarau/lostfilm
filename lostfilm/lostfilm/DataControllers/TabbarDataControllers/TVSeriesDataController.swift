import Foundation

class TVSeriesDataController: TemplateDataController<LFSeriesModel>, FilteringDelegate {

    var savedFilters: [LFSeriesFilterBaseModel] = []

    override func getItemListForPage(number: UInt, completionHander: @escaping ([LFSeriesModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.shared
        apiHelper.series.getListForPage(number, withParameters: transformFiltersIntoParameters() ?? nil, completionHandler: { seriesList, error in
            completionHander(seriesList, error as NSError?)
        })
    }

    func sendFiltersToTVSeriesDC(filters: [LFSeriesFilterBaseModel]) {
        savedFilters = filters
    }

    func add(filter: LFSeriesFilterBaseModel) {
        savedFilters.append(filter)
    }

    func remove(filter: LFSeriesFilterBaseModel) {
        if let index = savedFilters.firstIndex(of: filter) {
            savedFilters.remove(at: index)
        }
    }

    private func transformFiltersIntoParameters() -> [String: String]? {
        if savedFilters.isEmpty {
            return nil
        }

        let parameters = savedFilters.reduce(into: [String: String]()) { partialResult, savedFilter in
            partialResult[savedFilter.key, default: ""] += "\(savedFilter.value ?? ""),"
        }
        return parameters.mapValues { String($0.dropLast(",".count)) }

        // MARK: should work as well

//        let groupByKey: [String : [LFSeriesFilterBaseModel]] = Dictionary(grouping: savedFilters, by: {$0.key})
//        return groupByKey.reduce(into: [String : String]()) { partialResult, tuple in
//            partialResult.updateValue(tuple.value.map{$0.value}.joined(separator: ","), forKey: tuple.key)
//        }
    }
}
