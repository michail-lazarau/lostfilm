import Foundation

extension VideosVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    // TODO: Code may need refactoring - findViewController() function doesn't look a smooth solution for setting the videoViewCellDelegate in the ViewModel
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoViewCell.reuseIdentifier, for: indexPath) as? VideoViewCell
        cell?.item = item
        if let parent = tableView.findViewController() as? VideoPlayerDelegate {
            cell?.videoViewCellDelegate = parent
        }

        return cell ?? UITableViewCell()
    }
}
