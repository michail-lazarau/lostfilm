import Foundation

protocol CellConfigurable: UITableViewCell{
    associatedtype DataModel: LFJsonObject
    
    static var reuseIdentifier: String { get }
    var item: DataModel? { get set }
    func configureWith(dataModel: DataModel)
}
