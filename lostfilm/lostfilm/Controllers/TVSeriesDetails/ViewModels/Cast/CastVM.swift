import Foundation

class CastVM: BaseViewModel<TVSeriesCastDataProvider, LFPersonModel>, ILoadingDataForMultiSectionOnce {
    weak var delegate: IUpdatingViewDelegate?
    
    func loadItems() {
        loadItems(dataProvider: dataProvider) { [weak self] in
            self?.delegate?.updateTableView()
        }
    }
    
    func prepareDataModelForUse(_ dataModel: [LFPersonModel]) {
        items += dataModel
    }
}
