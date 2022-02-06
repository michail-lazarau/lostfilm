import UIKit

class LFSeriesDetailsVC: UIViewController, CarbonTabSwipeNavigationDelegate {
    var viewModel: SeriesVM
    let controllers: [UITableViewController]

    init(model: LFSeriesModel) {
        viewModel = SeriesVM(dataProvider: TVSeriesOverviewDC(model: model))
        controllers = [TVSeriesOverviewTVC(style: .grouped, viewModel: viewModel)]
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = SeriesVM()
        controllers = []
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let items = ["Test Title"]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
    }

    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return controllers[Int(index)]
    }
}
