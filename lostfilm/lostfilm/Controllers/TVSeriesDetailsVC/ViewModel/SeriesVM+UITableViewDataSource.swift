import Foundation

extension SeriesVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .poster:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SeriesPosterViewCell.reuseIdentifier, for: indexPath) as? SeriesPosterViewCell {
                cell.item = item
                return cell
            }
        case .detailPremiereDate, .detailChannelCountry, .detailRatingIMDb, .detailGenre, .detailType, .detailOfficialSite, .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SeriesDetailViewCell.reuseIdentifier, for: indexPath) as? SeriesDetailViewCell {
                cell.item = item
                return cell
            }
        }
        return UITableViewCell()
    }
}
