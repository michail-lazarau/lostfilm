import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class BaseViewModel<BaseDataProvider, Entity: Any>: NSObject {
    let dataProvider: BaseDataProvider
    var items = [Entity]()
    
    init(dataProvider: BaseDataProvider) {
        self.dataProvider = dataProvider
        super.init()
    }
}

