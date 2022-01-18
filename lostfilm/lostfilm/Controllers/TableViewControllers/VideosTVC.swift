import UIKit

class VideosTVC: TemplateTVC<VideoViewCell, LFVideoModel> {
    override internal var tableCellHeight: CGFloat {
        return 210
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Videos"
    }
}
