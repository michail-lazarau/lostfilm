import Foundation

extension SeriesVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList[section].rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemList[indexPath.section]
        switch item.type {
        case .poster:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SeriesPosterViewCell.reuseIdentifier, for: indexPath) as? SeriesPosterViewCell {
                cell.item = item
                return cell
            }
        default: break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        itemList[section].sectionTitle
    }
}
