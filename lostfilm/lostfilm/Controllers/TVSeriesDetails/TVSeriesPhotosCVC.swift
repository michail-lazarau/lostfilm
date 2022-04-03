import UIKit

class TVSeriesPhotosCVC: UICollectionViewController, UICollectionViewDataSourcePrefetching {
    var viewModel: PhotosVM
    private let navigationControllerDelegate = ZoomTransitioningDelegate()
    var selectedIndexPath: IndexPath?
    
    init(collectionViewLayout: UICollectionViewLayout, viewModel: PhotosVM) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: collectionViewLayout)
        self.viewModel.dataProvider?.delegate = self
//        navigationController?.delegate = navigationControllerDelegate
    }

    required init?(coder: NSCoder) {
        viewModel = PhotosVM()
        super.init(coder: coder)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
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
    private let customNavigationControllerDelegate = CustomNavigationControllerDelegate()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath) as! SeriesPhotoViewCell
        let photoVC = TVSeriesPhotoVC(nibName: TVSeriesPhotoVC.nibName, bundle: nil, image: cell.imageView.image)
        
        navigationController?.pushViewController(photoVC, animated: true)
//        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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

//extension TVSeriesPhotosCVC: ImageViewZoomable {
//    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
//        if let indexPath = selectedIndexPath {
//            let cell = collectionView.cellForItem(at: indexPath) as! SeriesPhotoViewCell
//            return cell.imageView
//        }
//        return nil
//    }
//}
