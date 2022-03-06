import UIKit

class NewsTVC: TemplateTVC<NewsViewCell, LFNewsModel> {
    override internal var tableCellHeight: CGFloat {
        return 120
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News"
    }
}
