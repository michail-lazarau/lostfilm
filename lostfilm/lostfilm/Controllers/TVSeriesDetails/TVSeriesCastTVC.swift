import UIKit

class TVSeriesCastTVC: UITableViewController, IUpdatingViewDelegate {
    let viewModel: CastVM
    
    private let initialScreenLoadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init(style: UITableView.Style, viewModel: CastVM) {
        self.viewModel = viewModel
        super.init(style: style)
        self.viewModel.delegate = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        tableView.dataSource = viewModel
        tableView.backgroundView = initialScreenLoadingSpinner
        initialScreenLoadingSpinner.startAnimating()
        viewModel.loadItems()
    }
    
    func updateTableView() {
        tableView.reloadData()
        initialScreenLoadingSpinner.stopAnimating()
    }

    private func registerCells() {
        tableView.register(SeriesCastViewCell.nib, forCellReuseIdentifier: SeriesCastViewCell.reuseIdentifier)
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
