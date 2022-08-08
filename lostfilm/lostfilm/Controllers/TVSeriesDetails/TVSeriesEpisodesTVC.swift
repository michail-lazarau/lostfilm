import UIKit

class TVSeriesEpisodesTVC: UITableViewController, IUpdatingViewDelegate {
    var viewModel: EpisodesVM

    init(style: UITableView.Style, viewModel: EpisodesVM) {
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
        viewModel.loadItems()
    }

    func updateTableView() {
        tableView.reloadData()
    }

    private func registerCells() {
        tableView.register(EpisodeViewCell.nib, forCellReuseIdentifier: EpisodeViewCell.reuseIdentifier)
        tableView.register(EpisodeTableHeaderView.nib, forHeaderFooterViewReuseIdentifier: EpisodeTableHeaderView.reuseIdentifier)
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = viewModel.items[section]
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: EpisodeTableHeaderView.reuseIdentifier) as? EpisodeTableHeaderView
        header?.item = item
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = viewModel.items[section]
        if item.seasonPosterUrl != nil && item.seasonDetails != nil {
            return 200
        } else {
            return 50
        }
    }
}
