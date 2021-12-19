import UIKit

class TVSeriesTableViewController: TemplateTableViewController<SeriesViewCell, LFSeriesModel> {

    override internal var tableCellHeight: CGFloat {
        return 175
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TV Series"
    }
}
