import Foundation

protocol PaginatedDataViewable {
    var lastVisibleRow: NSInteger? { get }
    func insertObjects(at indexPath: [IndexPath])
    func reloadData()
    func registerCell(nib: UINib?, forCellReuseIdentifier: String)
}

extension UITableView: PaginatedDataViewable {
    func registerCell(nib: UINib?, forCellReuseIdentifier: String) {
        register(nib, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func insertObjects(at indexPath: [IndexPath]) {
        insertRows(at: indexPath, with: .automatic)
    }
    
    var lastVisibleRow: NSInteger? {
        indexPathsForVisibleRows?.last?.row
    }
}
extension UICollectionView: PaginatedDataViewable {
    func registerCell(nib: UINib?, forCellReuseIdentifier: String) {
        register(nib, forCellWithReuseIdentifier: forCellReuseIdentifier)
    }
    
    func insertObjects(at indexPath: [IndexPath]) {
        insertItems(at: indexPath)
    }
    
    var lastVisibleRow: NSInteger? {
        indexPathsForVisibleItems.last?.item
    }
}
