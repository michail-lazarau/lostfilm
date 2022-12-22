import UIKit

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
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(title: "T", style: .plain, target: self, action: #selector(DidToggleToast2)))
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.delegate = customNavigationControllerDelegate
        navigationController?.pushViewController(LFSeriesDetailsVC(model: dataController[indexPath.row]), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Toast Test
    private var overlayWindow: UIWindow!
    @objc private func DidToggleToast2() {
        guard let scene = view.window?.windowScene else {
            return
        }
//        let label = UILabel(frame: .infinite)
//        label.backgroundColor = UIColor.systemBlue
//        label.font = UIFont.systemFont(ofSize: 12.0)
//        label.text = "Toast Text"
////        label.isUserInteractionEnabled = true
        let button = UIButton()
        button.setTitle("Toast Text", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button.backgroundColor = UIColor.systemBlue

        let alertWindow = AlertWindow(label: button, windowScene: scene)
        alertWindow.backgroundColor = .clear
        alertWindow.windowLevel = UIWindow.Level.alert
//        label.center = alertWindow.center

        alertWindow.makeKeyAndVisible()
        self.overlayWindow = alertWindow
    }

    @objc private func DidToggleToast() {
        guard let scene = view.window?.windowScene else {
            return
        }
        let overlayWindow = UIWindow(windowScene: scene)
//        let screenSize = UIScreen.main.bounds
//        let overlayWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: screenSize.width / 2, height: screenSize.height / 2))
        overlayWindow.canResizeToFitContent = true
        overlayWindow.isOpaque = false
//        overlayWindow.isUserInteractionEnabled = false
//        overlayWindow.frame.origin = CGPoint(x: UIScreen.main.bounds.width / 2 - overlayWindow.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - overlayWindow.bounds.height)
//        overlayWindow.backgroundColor = .systemGray
        overlayWindow.backgroundColor = .clear
//        overlayWindow.isHidden
        overlayWindow.windowLevel = UIWindow.Level.alert
        let presentingController = UIViewController()
//        presentingController.view.backgroundColor = .systemPink
        presentingController.view.backgroundColor = .clear
        presentingController.view.isUserInteractionEnabled = false
//        presentingController.view.alpha = 0.5

        presentingController.view.isOpaque = false
//        presentingController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            presentingController.view.centerXAnchor.constraint(equalTo: UIScreen.main.focusedView!.centerXAnchor),
////            presentingController.view.centerYAnchor.constraint(equalTo: overlayWindow.centerYAnchor, constant: UIScreen.main.bounds.height / 2 / 3)
//        ])
//        presentingController.view.backgroundColor = .cyan
//        presentingController.view.frame.size = CGSize(width: 100, height: 50)
//        presentingController.view.backgroundColor = .systemBlue

        let label = UILabel(frame: .infinite)
        label.backgroundColor = UIColor.systemBlue
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "Toast Text"

        presentingController.view.addSubview(label)
//        label.center = presentingController.view.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true


        let trailing = label.trailingAnchor.constraint(equalTo: presentingController.view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        trailing.priority = UILayoutPriority(750)
        let top = label.topAnchor.constraint(equalTo: presentingController.view.safeAreaLayoutGuide.topAnchor, constant: 0)
        top.priority = UILayoutPriority(750)
        let bottom = label.bottomAnchor.constraint(equalTo: presentingController.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottom.priority = UILayoutPriority(750)
        let leading = label.leadingAnchor.constraint(equalTo: presentingController.view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        leading.priority = UILayoutPriority(750)
        let width = label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width)
        width.priority = UILayoutPriority(1000)
        let height = label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height)
        let centerX = label.centerXAnchor.constraint(equalTo: presentingController.view.centerXAnchor)
        let centerY = label.centerYAnchor.constraint(equalTo: presentingController.view.centerYAnchor)
        NSLayoutConstraint.activate([
//            leading, trailing, top, bottom, width, height
            centerX, centerY
//            label.leadingAnchor.constraint(equalTo: presentingController.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
//            label.trailingAnchor.constraint(equalTo: presentingController.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
//            label.topAnchor.constraint(equalTo: presentingController.view.safeAreaLayoutGuide.topAnchor, constant: 400),
//            label.bottomAnchor.constraint(equalTo: presentingController.view.safeAreaLayoutGuide.bottomAnchor, constant: -300)

//            label.centerYAnchor.constraint(equalTo: presentingController.view.safeAreaLayoutGuide.centerYAnchor, constant: 0.0)
//            label.centerXAnchor.constraint(equalTo: presentingController.view.safeAreaLayoutGuide.centerXAnchor, constant: 0.0),
//            label.centerYAnchor.constraint(equalTo: presentingController.view.centerYAnchor, constant: UIScreen.main.bounds.height / 2 / 3)
        ])

//        overlayWindow.frame.size = label.frame.size

        overlayWindow.rootViewController = presentingController
//        overlayWindow.isHidden = false
        overlayWindow.makeKeyAndVisible()
        self.overlayWindow = overlayWindow
//        self.view.window = overlayWindow

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
