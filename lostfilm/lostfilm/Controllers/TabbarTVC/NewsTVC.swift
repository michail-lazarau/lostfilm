import UIKit

class NewsTVC: TemplateTVC<NewsViewCell, LFNewsModel> {
    override internal var tableCellHeight: CGFloat {
        return 120
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataSource = dataSource {
            let vm = NewsDetailsVM(dataProvider: NewsDetailsDataProvider(modelId: dataSource[indexPath.row].id))
            navigationController?.pushViewController(NewsDetailsTVC(style: .plain, viewModel: vm), animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
