import UIKit

class VideosTVC: TemplateTVC<VideoViewCell, LFVideoModel>, VideoPlayerDelegate {
    override internal var tableCellHeight: CGFloat {
        return UIScreen.main.bounds.width / 16 * 9
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! VideoViewCell
        cell.videoViewCellDelegate = self
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Videos"
    }
}
