import UIKit

class LFSeriesDetailsVC: UIViewController, CarbonTabSwipeNavigationDelegate {
    var viewModel: SeriesVM
    let controllers: [UITableViewController]

    init(model: LFSeriesModel) {
        viewModel = SeriesVM(dataProvider: TVSeriesOverviewDC(model: model))
        controllers = [TVSeriesOverviewTVC(style: .plain, viewModel: viewModel)]
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = SeriesVM()
        controllers = []
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let items = ["Обзор сериала"]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        carbonTabSwipeNavigation.toolbar.isTranslucent = false
        
        self.navigationItem.title = viewModel.dataProvider?.model.nameRu
        self.navigationItem.largeTitleDisplayMode = .never
        carbonTabSwipeNavigation.navigationController?.navigationBar.backgroundColor = .white
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
