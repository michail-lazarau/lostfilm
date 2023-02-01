import UIKit
import WindowToast

class TVSeriesTVC: TemplateTVC<SeriesViewCell, LFSeriesModel> {

    private let customNavigationControllerDelegate = CustomNavigationControllerDelegate()

    override internal var tableCellHeight: CGFloat {
        return 175
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TV Series"
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(image: UIImage(named: "icon_filter"), style: .plain, target: self, action: #selector(DidShowFilters)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "magnifying_glass"), style: .plain, target: self, action: #selector(DidShowGlobalSearch))

        // Toast Test
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(title: "T", style: .plain, target: self, action: #selector(didToggleToast)))
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.delegate = customNavigationControllerDelegate
        navigationController?.pushViewController(LFSeriesDetailsVC(model: dataController[indexPath.row]), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Toast Test
    private let toastPresenter = ToastPresenter.shared

    @objc private func didToggleToast() {
        let toastView = DefaultToastView(image: UIImage(named: "magnifying_glass"))
        toastView.messageLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        toastView.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"

        let toastManager = ToastManager(playPosition: ToastPosition(xAxisPosition: .center(), yAxisPosition: .top(constant: YAxisPosition.navigationBarIndent)),
                                        prePosition: ToastPosition(xAxisPosition: .center(), yAxisPosition: .top(constant: YAxisPosition.notchIndent)),
                                        postPosition: ToastPosition(xAxisPosition: .center(), yAxisPosition: .top(constant: YAxisPosition.notchIndent)))
        toastPresenter.enqueueToastForPresentation(toast: toastView, toastManager: toastManager)
    }

    @objc private func DidShowFilters() {
        guard let dataController = dataController as? TVSeriesDataController & FilteringDelegate else {
            return
        }

        let filteringTVC = FilteringTVC(style: .grouped, DCwithSavedFilters: dataController)
        let navController = FilteringNavigationController(rootViewController: filteringTVC)
        filteringTVC.filteringDelegate = dataController
        present(navController, animated: true)
    }

    @objc private func DidShowGlobalSearch() {
        let globalSearchTVC = GlobalSearchTVC(style: .grouped, viewModel: GlobalSearchVM(dataProvider: GlobalSearchDC()))
        if let presentedVC = presentedViewController {
            presentedVC.dismiss(animated: false, completion: nil)
        }

        navigationController?.setViewControllers([self, globalSearchTVC], animated: true)
    }
}

// MARK: how to display a VC

//    addChild(filteringTVC)
//    self.view.addSubview(filteringTVC.view)
//    filteringTVC.didMove(toParent: self)

//    navVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    navigationController?.pushViewController(FilteringTVC(), animated: true)

//    show(FilteringTVC(), sender: navigationItem.rightBarButtonItem)
