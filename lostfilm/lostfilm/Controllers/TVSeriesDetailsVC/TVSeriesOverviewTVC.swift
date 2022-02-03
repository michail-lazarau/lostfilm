import UIKit

class TVSeriesOverviewTVC: UITableViewController {
    var viewModel: LFSeriesVM
    
    init(style: UITableView.Style, viewModel: LFSeriesVM) {
        self.viewModel = viewModel
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        viewModel = LFSeriesVM()
        super.init(coder: coder)
        view.backgroundColor = .white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = viewModel
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
    }
//   didSelectRowAt
}
