import Foundation

final class CastVM: BaseViewModel<TVSeriesCastDataProvider, LFPersonModel>, ILoadingDataOnce {
    weak var delegate: IUpdatingViewDelegate?

    func loadItems() {
        loadItems(dataProvider: dataProvider) { [weak self] in
            self?.delegate?.updateView()
        }
    }

    func prepareDataModelForUse(_ dataModel: [LFPersonModel]) {
        items += dataModel
    }
}
