import Foundation

extension CastVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: SeriesCastViewCell.reuseIdentifier, for: indexPath) as? SeriesCastViewCell {
            cell.item = item
            return cell
        }
        return UITableViewCell()
    }
}
