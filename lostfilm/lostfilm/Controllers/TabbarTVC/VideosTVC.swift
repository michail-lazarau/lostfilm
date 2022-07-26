import UIKit

class VideosTVC: TemplateTVC<VideoViewCell, LFVideoModel> {
    override internal var tableCellHeight: CGFloat {
        return UIScreen.main.bounds.width / 16 * 9
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Videos"
    }
}
