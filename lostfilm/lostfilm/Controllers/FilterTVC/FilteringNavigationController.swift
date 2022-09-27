import UIKit

class FilteringNavigationController: UINavigationController {
    let showSeriesButton = NavigationViewButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        view.addSubview(showSeriesButton)
        setupButtonConstraints()
        showSeriesButton.addTarget(self, action: #selector(dismissViewControllers), for: .touchUpInside)
    }

     @objc func dismissViewControllers() {
        popToRootViewController(animated: false) // MARK: i'm so ashamed it's working this way along with viewWillDisappear implementation in the FilteringTVC class
        dismiss(animated: true, completion: nil)
    }

    private func setupButtonConstraints() {
        showSeriesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showSeriesButton.heightAnchor.constraint(equalToConstant: 40.0),
            showSeriesButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5.0),
            showSeriesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5.0),
            showSeriesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50.0)
        ])
    }
}
