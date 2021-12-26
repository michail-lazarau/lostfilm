import UIKit

class NewEpisodesTableViewController: TemplateTableViewController<NewEpisodeViewCell, LFEpisodeModel> {
    override internal var tableCellHeight: CGFloat {
        return 144
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Episodes"
    }
}
