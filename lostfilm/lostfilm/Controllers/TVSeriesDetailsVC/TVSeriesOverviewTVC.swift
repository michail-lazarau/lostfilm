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
        registerCell()
        tableView.dataSource = viewModel
        viewModel.dataProvider?.getDetails()
    }
    
    func updateTableView() {
        if let model = viewModel.dataProvider?.model {
            viewModel.setupVMwith(model: model)
        }
        tableView.reloadData()
    }

    func registerCell() {
        let nib = UINib(nibName: SeriesPosterViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SeriesPosterViewCell.reuseIdentifier)
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        175
    }

    //   didSelectRowAt
}

// Uncomment the following line to preserve selection between presentations
// self.clearsSelectionOnViewWillAppear = false

// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
// self.navigationItem.rightBarButtonItem = self.editButtonItem
