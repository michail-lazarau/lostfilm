import UIKit

class TVSeriesOverviewTVC: UITableViewController, DelegateTVSeriesOverviewDC {
    var viewModel: SeriesVM

    init(style: UITableView.Style, viewModel: SeriesVM) {
        self.viewModel = viewModel
        super.init(style: style)
        self.viewModel.dataProvider?.delegate = self
    }
  
    required init?(coder: NSCoder) {
        viewModel = SeriesVM()
        super.init(coder: coder)
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        tableView.dataSource = viewModel
        viewModel.dataProvider?.getDetails()
        
        tableView.sectionHeaderHeight = 0.0
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.clear
    }
    
    func updateTableView() {
        if let model = viewModel.dataProvider?.model {
            viewModel.setupVMwith(model: model)
        }
        tableView.reloadData()
    }

    func registerCells() {
        tableView.register(SeriesPosterViewCell.nib, forCellReuseIdentifier: SeriesPosterViewCell.reuseIdentifier)
        tableView.register(SeriesDetailViewCell.nib, forCellReuseIdentifier: SeriesDetailViewCell.reuseIdentifier)
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.items[indexPath.section]
        switch item.type {
        case .poster:
            return 175
        case .detailPremiereDate, .detailChannelCountry, .detailRatingIMDb, .detailGenre, .detailType, .detailOfficialSite:
            return 50
        case .description:
//            tableView.estimatedRowHeight = 600
//            return tableView.estimatedRowHeight
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
