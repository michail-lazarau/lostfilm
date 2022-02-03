import Foundation

extension LFSeriesVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList[section].rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        <#code#>
    }
}
