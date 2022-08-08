import Foundation

// FIXME: OUT OF USE - DELETE CLASS LATER
class HomogeneousTableViewModel {
//class HomogeneousTableViewModel<Data, CellType: CellConfigurable>: NSObject, ViewModelable, UITableViewDataSource {
//    var dataProvider: IHaveDataModelBySeriesIdAndPage?
//
//    // MARK: UITableViewDataSource
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if (itemCount == 0) {
//            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//            noDataLabel.text = "No Data Found."
//            noDataLabel.textColor = UIColor.red
//            noDataLabel.textAlignment = .center
//            tableView.backgroundView = noDataLabel
//        } else {
//            tableView.backgroundView = nil
//        }
//        return 1
//    }
//
//    // MARK: UITableViewDataSource
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return itemCount
//    }
//
//    // MARK: UITableViewDataSource
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = itemList[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseIdentifier, for: indexPath) as? CellType
//        cell?.item = item as? CellType.DataModel
//        return cell ?? UITableViewCell()
//    }
}
