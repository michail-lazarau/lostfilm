import UIKit

class VideosTableViewController: TemplateTableViewController<VideoViewCell, LFVideoModel> {
    
    override internal var tableCellHeight: CGFloat {
        return 210
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Videos"
    }
}
