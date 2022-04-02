import UIKit

class LFSeriesDetailsVC: UIViewController, CarbonTabSwipeNavigationDelegate {
    private let navigationControllerDelegate = ZoomTransitioningDelegate()
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
        
        let navControllerForTVSeriesPhotosCVC = UINavigationController(rootViewController: TVSeriesPhotosCVC(collectionViewLayout: collectionLayout, viewModel: photosViewModel))
        navControllerForTVSeriesPhotosCVC.delegate = navigationControllerDelegate
        
        controllers = [TVSeriesOverviewTVC(style: .plain, viewModel: viewModel),
                       TVSeriesEpisodesTVC(style: .plain, viewModel: episodesViewModel),
                       TVSeriesNewsTVC(style: .plain, viewModel: newsViewModel),
                       navControllerForTVSeriesPhotosCVC]
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = SeriesVM()
        controllers = []
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let items = ["Обзор сериала", "Гид по сериям", "Новости", "Фото"] // MARK: refactor this - make localization
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation?.insert(intoRootViewController: self)
        carbonTabSwipeNavigation?.toolbar.isTranslucent = false
        
        self.navigationItem.title = viewModel.dataProvider?.model.nameRu
        self.navigationItem.largeTitleDisplayMode = .never
        carbonTabSwipeNavigation?.navigationController?.navigationBar.backgroundColor = .white
//        carbonTabSwipeNavigation.setNormalColor(.white)
//        carbonTabSwipeNavigation.carbonSegmentedControl?.backgroundColor = .white
//        carbonTabSwipeNavigation.toolbar.clipsToBounds = true
    }

//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        super.viewWillAppear(animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.shadowImage = nil
//        super.viewWillDisappear(animated)
//    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return controllers[Int(index)]
    }
}
