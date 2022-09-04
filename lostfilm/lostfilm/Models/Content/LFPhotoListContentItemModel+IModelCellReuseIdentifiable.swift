import Foundation

extension LFPhotoListContentItemModel: IModelCellReuseIdentifiable {
    var cellReuseIdentifier: String {
        CarouselViewTableViewCell.reuseIdentifier
    }
}
