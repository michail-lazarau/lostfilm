import UIKit
import SDWebImage

class TVSeriesPhotosCVC: UICollectionViewController, UICollectionViewDataSourcePrefetching {
    private var viewModel: PhotosVM
    var selectedIndexPath: IndexPath?
    
    init(collectionViewLayout: UICollectionViewLayout, viewModel: PhotosVM) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: collectionViewLayout)
        self.viewModel.dataProvider?.delegate = self
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        collectionView.dataSource = viewModel
        collectionView.prefetchDataSource = self
        viewModel.dataProvider?.didLoadItemsByPage()
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    
    private func registerCells() {
        collectionView.register(SeriesPhotoViewCell.nib, forCellWithReuseIdentifier: SeriesPhotoViewCell.reuseIdentifier)
    }

    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        viewModel.dataProvider?.didEmptyItemList()
        viewModel.dataProvider?.didLoadItemsByPage()
        sender.endRefreshing()
    }
    
    // MARK: - DataSourcePrefetching

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.dataProvider?.didLoadItemsByPage()
        }
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath) as! SeriesPhotoViewCell
        let photoVC = TVSeriesPhotoVC(nibName: TVSeriesPhotoVC.nibName, bundle: nil, model: cell.item!, image: cell.imageView.image ?? UIImage())
        navigationController?.pushViewController(photoVC, animated: true)
    }
}

extension TVSeriesPhotosCVC {
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let lastVisibleItem = collectionView.indexPathsForVisibleItems.last?.item else {
            return false
        }
        return lastVisibleItem >= viewModel.itemCount - 1
    }
}

extension TVSeriesPhotosCVC: TVSeriesDetailsPaginatingDC_Delegate {
    func updateTableView(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            collectionView.reloadData()
            return
        }
        collectionView.insertItems(at: newIndexPathsToReload)
    }
}
