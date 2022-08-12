import Foundation

extension GlobalSearchVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemsForSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsForSections[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemsForSections[indexPath.section]
        switch item.type {
        case .series:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SeriesViewCell.reuseIdentifier, for: indexPath) as? SeriesViewCell, let item = item as? GlobalSearchSeriesItem {
                cell.configureWith(dataModel: item[indexPath.row])
                return cell
            }
        case .persons:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SeriesCastViewCell.reuseIdentifier, for: indexPath) as? SeriesCastViewCell,  let item = item as? GlobalSearchPersonsItem {
                cell.item = item[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
}
