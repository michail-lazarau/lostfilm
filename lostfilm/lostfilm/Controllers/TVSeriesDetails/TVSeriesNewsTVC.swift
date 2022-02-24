import UIKit

class TVSeriesNewsTVC: UITableViewController, DelegateTVSeriesDetailsDC {
    var viewModel: NewsVM

    init(style: UITableView.Style, viewModel: NewsVM) {
        self.viewModel = viewModel
        super.init(style: style)
        self.viewModel.dataProvider?.delegate = self
    }
  
    required init?(coder: NSCoder) {
        viewModel = NewsVM()
        super.init(coder: coder)
        view.backgroundColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        tableView.dataSource = viewModel
        viewModel.dataProvider?.loadDataByPage()
    }

    func updateTableView() {
        if let newsList = viewModel.dataProvider?.newsList { // MARK: refactor this - put this code inside of dataProvider if there's no reason to leave here
            viewModel.setupVMwith(modelList: newsList)
        }
        tableView.reloadData()
    }
    
    func registerCells() {
        tableView.register(SeriesNewsViewCell.nib, forCellReuseIdentifier: SeriesNewsViewCell.reuseIdentifier)
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
