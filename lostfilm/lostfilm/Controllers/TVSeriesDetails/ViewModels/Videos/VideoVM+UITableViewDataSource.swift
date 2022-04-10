import Foundation

extension VideoVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = videoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SeriesNewsViewCell.reuseIdentifier, for: indexPath) as? SeriesNewsViewCell
//        cell?.item = item // FIXME: uncomment
        return cell ?? UITableViewCell()
    }
}
