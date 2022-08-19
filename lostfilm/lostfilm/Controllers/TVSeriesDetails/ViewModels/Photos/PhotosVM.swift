import Foundation

class PhotosVM: BaseViewModel<TVSeriesPhotosDC, LFPhotoModel>, ILoadingHomogeneousItemsByPage {
    var currentPage: UInt = 0
    var isLoading: Bool = false
    weak var delegate: IUpdatingViewByPageDelegate?
    
    func loadItemsByPage() {
        loadItemsByPage(dataProvider: dataProvider) { [weak self] indexPaths in
            self?.delegate?.updateTableView(with: indexPaths)
        }
    }
}
