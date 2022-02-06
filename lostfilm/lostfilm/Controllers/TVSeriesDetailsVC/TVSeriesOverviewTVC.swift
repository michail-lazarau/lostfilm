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
        tableView.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 100
        viewModel.dataProvider?.getDetails()
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

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        tableView.cellForRow(at: indexPath).
//        tableView.rowHeight = UITableView.automaticDimension
//        let item = viewModel.items[indexPath.section]
//        switch item.type {
//        case .poster:
//            return 175
//        case .detailPremiereDate:
//            <#code#>
//        case .detailChannelCountry:
//            <#code#>
//        case .detailRatingIMDb:
//            <#code#>
//        case .detailGenre:
//            <#code#>
//        case .detailType:
//            <#code#>
//        case .detailOfficialSite:
//            <#code#>
//        case .description:
//            tableView.estimatedRowHeight = 600
//        default: tableView.estimatedRowHeight = 50
//        }
//    }
    
    //   didSelectRowAt
}

// Uncomment the following line to preserve selection between presentations
// self.clearsSelectionOnViewWillAppear = false

// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
// self.navigationItem.rightBarButtonItem = self.editButtonItem
