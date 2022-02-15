import UIKit

class TVSeriesEpisodesTVC: UITableViewController, DelegateTVSeriesOverviewDC {
    var viewModel: EpisodesVM

    init(style: UITableView.Style, viewModel: EpisodesVM) {
        self.viewModel = viewModel
        super.init(style: style)
        self.viewModel.dataProvider?.delegate = self
    }

    required init?(coder: NSCoder) {
        viewModel = EpisodesVM()
        super.init(coder: coder)
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateTableView() {
//        <#code#>
    }

    func registerCells() {
        tableView.register(EpisodeViewCell.nib, forCellReuseIdentifier: EpisodeViewCell.reuseIdentifier)
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
