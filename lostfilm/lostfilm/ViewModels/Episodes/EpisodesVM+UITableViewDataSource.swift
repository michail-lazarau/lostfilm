import Foundation

extension EpisodesVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section].episodeList[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeViewCell.reuseIdentifier, for: indexPath) as? EpisodeViewCell {
            cell.item = item
            return cell
        }
        return UITableViewCell()
    }
}
