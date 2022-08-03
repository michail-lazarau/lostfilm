import Foundation

extension NewsVM: UITableViewDataSource {   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SeriesNewsViewCell.reuseIdentifier, for: indexPath) as? SeriesNewsViewCell
        cell?.item = item
        return cell ?? UITableViewCell()
    }
}
