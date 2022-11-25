import UIKit

class LFSeriesDetailsVC: UIViewController, CarbonTabSwipeNavigationDelegate {
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation?
    let viewModel: SeriesVM // MARK: make let?
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
        viewModel = SeriesVM(dataProvider: TVSeriesOverviewDataProvider(modelId: model.id))
        let episodesViewModel = EpisodesVM(dataProvider: TVSeriesEpisodesDataProvider(modelId: model.id))
        let newsViewModel = NewsVM(dataProvider: TVSeriesNewsDataProvider(modelId: model.id))
        let videosViewModel = VideosVM(dataProvider: TVSeriesVideosDataProvider(modelId: model.id))
        let photosViewModel = PhotosVM(dataProvider: TVSeriesPhotosDataProvider(modelId: model.id))
        let castViewModel = CastVM(dataProvider: TVSeriesCastDataProvider(modelId: model.id))

        controllers = [TVSeriesOverviewTVC(style: .plain, viewModel: viewModel),
                       TVSeriesEpisodesTVC(style: .plain, viewModel: episodesViewModel),
                       TVSeriesNewsTVC(style: .plain, viewModel: newsViewModel),
                       TVSeriesVideosTVC(style: .plain, viewModel: videosViewModel),
                       TVSeriesPhotosCVC(collectionViewLayout: collectionLayout, viewModel: photosViewModel),
                       TVSeriesCastTVC(style: .plain, viewModel: castViewModel)]

        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = model.nameRu
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let items = [NSLocalizedString("Overview", comment: ""), NSLocalizedString("Episodes", comment: ""), NSLocalizedString("News", comment: ""), NSLocalizedString("Video", comment: ""), NSLocalizedString("Photo", comment: ""), NSLocalizedString("Cast", comment: "")]
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation?.insert(intoRootViewController: self)
        carbonTabSwipeNavigation?.toolbar.isTranslucent = false
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
        let collectionViewController = self.controllers.last { $0 is TVSeriesPhotosCVC } as? TVSeriesPhotosCVC
        if let TVSeriesPhotosCVC = collectionViewController, let indexPath = TVSeriesPhotosCVC.selectedIndexPath {
            let cell = TVSeriesPhotosCVC.collectionView.cellForItem(at: indexPath) as? SeriesPhotoViewCell
            return cell?.imageView
        }
        return nil
    }
}
