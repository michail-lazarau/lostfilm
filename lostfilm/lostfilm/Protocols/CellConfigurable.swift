import Foundation

protocol CellConfigurable: UITableViewCell{
    associatedtype DataModel: LFJsonObject
    
    static var reuseIdentifier: String { get }
    func configureWith(dataModel: DataModel)
}
