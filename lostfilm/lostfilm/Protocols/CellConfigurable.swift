import Foundation

protocol CellConfigurable: UITableViewCell{
    associatedtype DataModel: LFJsonObject
    
    static func cellIdentifier() -> String
    func configureWith(dataModel: DataModel)
}
