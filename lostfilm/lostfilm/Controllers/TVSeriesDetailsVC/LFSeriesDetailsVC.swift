import UIKit

class LFSeriesDetailsVC: UIViewController, CarbonTabSwipeNavigationDelegate {
    var viewModel: LFSeriesVM
    let controllers: [UITableViewController]

    init(model: LFSeriesModel) {
        viewModel = LFSeriesVM(model: model)
        controllers = [TVSeriesOverviewTVC(style: .grouped, viewModel: viewModel)]
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = LFSeriesVM()
        controllers = []
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: controllers, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
    }

    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return controllers[Int(index)]
    }
}
