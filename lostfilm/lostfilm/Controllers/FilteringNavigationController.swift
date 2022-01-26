import UIKit

class FilteringNavigationController: UINavigationController {
    let showSeriesButton = NavigationViewButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        view.addSubview(showSeriesButton)
        setupButtonConstraints()
    }
    
    private func setupButtonConstraints() {
        showSeriesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showSeriesButton.heightAnchor.constraint(equalToConstant: 40.0),
            showSeriesButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5.0),
            showSeriesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5.0),
            showSeriesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50.0),
        ])
    }
}
