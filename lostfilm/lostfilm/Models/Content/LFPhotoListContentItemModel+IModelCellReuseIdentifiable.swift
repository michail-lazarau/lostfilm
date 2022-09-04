import Foundation

extension LFPhotoListContentItemModel: IModelCellReuseIdentifiable {
    var cellReuseIdentifier: String {
        CarouselTableViewCell.reuseIdentifier
    }
}
