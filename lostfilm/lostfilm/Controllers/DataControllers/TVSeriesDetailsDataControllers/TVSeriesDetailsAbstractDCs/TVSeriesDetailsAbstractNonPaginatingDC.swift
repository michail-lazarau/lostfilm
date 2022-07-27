import Foundation

class TVSeriesDetailsAbstractNonPaginatingDC<DataModel>: TVSeriesDetailsAbstract {
    var itemList: DataModel?
    weak var delegate: TVCUpdatingDelegate?

    func getDetails() {
        getItemListForSeriesBy(seriesId: tvSeriesModel.id) { [weak self] itemList, _ in
            guard let strongSelf = self, let itemList = itemList else {
                return
            }
            strongSelf.itemList = itemList
            DispatchQueue.main.async {
                strongSelf.delegate?.updateTableView()
            }
        }
    }

    func getItemListForSeriesBy(seriesId: String, completionHandler: @escaping (DataModel?, NSError?) -> Void) {
        fatalError("This func must be overridden")
    }
}
