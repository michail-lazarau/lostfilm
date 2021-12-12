import Foundation

protocol CellConfigurable: UITableViewCell{
    associatedtype DataModel: LFJsonObject
    
    func configureWith(dataModel: DataModel)
}
