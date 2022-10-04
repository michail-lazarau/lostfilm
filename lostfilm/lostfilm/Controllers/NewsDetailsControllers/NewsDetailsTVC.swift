import UIKit

class NewsDetailsTVC: UITableViewController, IUpdatingViewDelegate {
    let viewModel: NewsDetailsVM

    private let initialScreenLoadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.hidesWhenStopped = true
        return spinner
    }()

    init(style: UITableView.Style, viewModel: NewsDetailsVM) {
        self.viewModel = viewModel
        super.init(style: style)
        self.viewModel.viewUpdatingDelegate = self
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
        navigationItem.largeTitleDisplayMode = .never
        viewModel.loadItems()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func updateView() {
        tableView.reloadData()
        initialScreenLoadingSpinner.stopAnimating()
    }

    private func registerCells() {
        tableView.register(VideoViewCell.self, forCellReuseIdentifier: VideoViewCell.reuseIdentifier)
        tableView.register(TextViewCell.nib, forCellReuseIdentifier: TextViewCell.reuseIdentifier)
        tableView.register(CarouselTableViewCell.nib, forCellReuseIdentifier: CarouselTableViewCell.reuseIdentifier)
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.items[indexPath.row]
        let height: CGFloat
        switch item {
        case is LFVideoContentItemModel, is LFPhotoListContentItemModel:
            height = UIScreen.main.bounds.width / 16 * 9
        default:
            height = UITableView.automaticDimension
        }
        return height
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
