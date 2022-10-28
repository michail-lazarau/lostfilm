import Foundation

final class NewsDetailsVM: BaseViewModel<NewsDetailsDataProvider, LFContentItemModel>, ILoadingDataOnce {
    weak var viewUpdatingDelegate: IUpdatingViewDelegate?
    func loadItems() {
        loadItems(dataProvider: dataProvider) { [weak self] in
            self?.viewUpdatingDelegate?.updateView()
        }
    }

    func prepareDataModelForUse(_ dataModel: LFNewsModel) {
        for item in dataModel.content.items {
            items.append(item)
        }
    }
}

extension NewsDetailsVM: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let identifier = (item as! IModelCellReuseIdentifiable).cellReuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        switch item {
            // MARK: force unwrapping is put by intention - items array must not contain any objects those do not conform to the Class Types mentioned below

        case is LFAttributedTextContentItemModel:
            (cell as! TextViewCell).item = item
        case is LFPhotoListContentItemModel:
            (cell as! CarouselTableViewCell).item = item
        case is LFVideoContentItemModel:
            (cell as! VideoViewCell).item = (item as! LFVideoContentItemModel).videoModel
        default: fatalError("\(NewsDetailsVM.self): cell cannot be free of data")
        }
        return cell
    }
}
