import UIKit

private let reuseIdentifier = "Cell"

class TVSeriesPhotosCVC: UICollectionViewController, UICollectionViewDataSourcePrefetching {
    var viewModel: PhotosVM

    init(collectionViewLayout: UICollectionViewLayout, viewModel: PhotosVM) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: collectionViewLayout)
        self.viewModel.dataProvider?.delegate = self
    }

    required init?(coder: NSCoder) {
        viewModel = PhotosVM()
        super.init(coder: coder)
        view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        collectionView.dataSource = viewModel
        collectionView.prefetchDataSource = self
        viewModel.dataProvider?.loadItemsByPage()
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    
    func registerCells() {
        collectionView.register(SeriesPhotoViewCell.nib, forCellWithReuseIdentifier: SeriesPhotoViewCell.reuseIdentifier)
    }

    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        viewModel.dataProvider?.didEmptyNewsList()
        viewModel.dataProvider?.loadItemsByPage()
        sender.endRefreshing()
    }
    
    // MARK: - DataSourcePrefetching

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.dataProvider?.loadItemsByPage()
        }
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

private extension TVSeriesPhotosCVC {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let lastVisibleItem = collectionView.indexPathsForVisibleItems.last?.item else {
            return false
        }
        return lastVisibleItem >= viewModel.itemCount - 1
    }
}

extension TVSeriesPhotosCVC: DelegateTVSeriesDCwithPagination {
    func updateTableView(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            collectionView.reloadData()
            return
        }
        collectionView.insertItems(at: newIndexPathsToReload)
    }
}
