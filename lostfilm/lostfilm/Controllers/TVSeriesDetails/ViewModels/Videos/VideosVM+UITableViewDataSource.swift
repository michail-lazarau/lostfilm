import Foundation

extension VideosVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if (videoList.count == 0) {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No Data Found."
            noDataLabel.textColor = UIColor.red
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
        } else {
            tableView.backgroundView = nil
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = videoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoViewCell.reuseIdentifier, for: indexPath) as? VideoViewCell
        cell?.item = item
        return cell ?? UITableViewCell()
    }
}
