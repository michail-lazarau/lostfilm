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
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    // MARK: - Table view delegate
}
