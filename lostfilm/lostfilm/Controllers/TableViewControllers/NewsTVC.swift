import UIKit

class NewsTVC: TemplateTVC<NewsViewCell, LFNewsModel> {
    override internal var tableCellHeight: CGFloat {
        return 120
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News"
    }

//    override func registerCell() {
    ////        let className = String(describing: NewsViewCell.self)
    ////        let nib: UINib = Bundle.main.loadNibNamed(NewsViewCell.cellIdentifier(), owner: nil, options: nil)?.first as! UINib
//        let nib = UINib(nibName: NewsViewCell.cellIdentifier(), bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: NewsViewCell.cellIdentifier())
//    }
}
