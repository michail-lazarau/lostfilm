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
        let model = items[indexPath.row]
        guard let identifier = (model as? IModelCellReuseIdentifiable)?.cellReuseIdentifier else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        switch model {
        case is LFAttributedTextContentItemModel:
            (cell as? TextViewCell)?.item = model
        case is LFPhotoListContentItemModel:
            (cell as? CarouselTableViewCell)?.item = model
        case is LFVideoContentItemModel:
            (cell as? VideoViewCell)?.item = (model as? LFVideoContentItemModel)?.videoModel
        default:
            print("\(model.self) does not suit to the given types")
        }
        return cell
    }
}
