import UIKit

class LFSeriesDetailsVC: UIViewController, CarbonTabSwipeNavigationDelegate {
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation?
    var viewModel: SeriesVM // MARK: make let?
    let controllers: [UIViewController]
    let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3.0, height: UIScreen.main.bounds.width/3.0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()

    init(model: LFSeriesModel) {
        viewModel = SeriesVM(dataProvider: TVSeriesOverviewDC(model: model))
        let episodesViewModel = EpisodesVM(dataProvider: TVSeriesEpisodesDC(model: model))
        let newsViewModel = NewsVM(dataProvider: TVSeriesNewsDC(model: model))
        let photosViewModel = PhotosVM(dataProvider: TVSeriesPhotosDC(model: model))
        
        controllers = [TVSeriesOverviewTVC(style: .plain, viewModel: viewModel),
                       TVSeriesEpisodesTVC(style: .plain, viewModel: episodesViewModel),
                       TVSeriesNewsTVC(style: .plain, viewModel: newsViewModel),
                       TVSeriesPhotosCVC(collectionViewLayout: collectionLayout, viewModel: photosViewModel)]
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let items = ["Обзор сериала", "Гид по сериям", "Новости", "Фото"] // MARK: refactor this - make localization
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation?.insert(intoRootViewController: self)
        carbonTabSwipeNavigation?.toolbar.isTranslucent = false
        
        self.navigationItem.title = viewModel.dataProvider?.model.nameRu
        self.navigationItem.largeTitleDisplayMode = .never
        carbonTabSwipeNavigation?.modalPresentationCapturesStatusBarAppearance = true
        view.backgroundColor = .white
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return controllers[Int(index)]
    }
}

extension LFSeriesDetailsVC: ImageViewZoomable {
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        if let TVSeriesPhotosCVC = (self.controllers[3] as? TVSeriesPhotosCVC), let indexPath = TVSeriesPhotosCVC.selectedIndexPath {
            let cell = TVSeriesPhotosCVC.collectionView.cellForItem(at: indexPath) as! SeriesPhotoViewCell
            return cell.imageView
        }
        return nil
    }
}
