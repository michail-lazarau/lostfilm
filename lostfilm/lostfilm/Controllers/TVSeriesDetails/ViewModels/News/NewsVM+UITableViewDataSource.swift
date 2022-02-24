import Foundation

extension NewsVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section].newsList[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: SeriesNewsViewCell.reuseIdentifier, for: indexPath) as? SeriesNewsViewCell {
            cell.item = item
            return cell
        }
        return UITableViewCell()
    }
}
