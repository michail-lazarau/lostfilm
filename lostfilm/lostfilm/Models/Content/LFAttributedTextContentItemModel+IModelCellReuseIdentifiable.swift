import Foundation

extension LFAttributedTextContentItemModel: IModelCellReuseIdentifiable {
    var cellReuseIdentifier: String {
        TextViewCell.reuseIdentifier
    }
}
