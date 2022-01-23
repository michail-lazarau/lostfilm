import Foundation

class TVSeriesDataController: TemplateDataController<LFSeriesModel>, FilteringDelegate {
    var savedFilters: [LFSeriesFilterBaseModel] = []
    override func getItemListForPage(number: UInt, completionHander: @escaping ([LFSeriesModel]?, NSError?) -> Void) {
        let apiHelper = LFApplicationHelper.sharedApiHelper
//        let parameters: NSMutableDictionary = transformFiltersIntoParameters() ?? [:]
        apiHelper.series.getListForPage(number, withParameters: transformFiltersIntoParameters() as? [AnyHashable : Any], completionHandler: { seriesList, error in
                completionHander(seriesList, error as NSError?)
            })
    }
    
    func sendFiltersToTVSeriesDC(filters: [LFSeriesFilterBaseModel]) {
        savedFilters = filters
    }
    
    private func transformFiltersIntoParameters() -> NSMutableDictionary? {
        if savedFilters.isEmpty {
            return nil
        }
        
        let parameters = savedFilters.reduce(into: [String : String]()) { partialResult, LFSeriesFilterBaseModel in
            partialResult[LFSeriesFilterBaseModel.key, default: ""] += "\(String(describing: LFSeriesFilterBaseModel.value)) ,"
        }
        return (parameters.mapValues{$0.dropLast(" ,".count)} as NSDictionary).mutableCopy() as! NSMutableDictionary
        
//        MARK: should work as well
//        let groupByKey: [String : [LFSeriesFilterBaseModel]] = Dictionary(grouping: savedFilters, by: {$0.key})
//        return groupByKey.reduce(into: [String : String]()) { partialResult, tuple in
//            partialResult.updateValue(tuple.value.map{$0.value}.joined(separator: ", "), forKey: tuple.key)
//        }
    }
}
