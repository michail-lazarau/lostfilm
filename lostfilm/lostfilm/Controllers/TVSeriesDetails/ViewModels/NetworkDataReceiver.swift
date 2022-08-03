import Foundation

protocol NetworkDataReceiver {
    associatedtype DataModel: LFJsonObject
    var itemCount: Int { get }
    var itemList: [DataModel] { get }
    var dataProvider: TVSeriesDetailsAbstractPaginatingDC<DataModel>? { get set }
    
    init(dataProvider: TVSeriesDetailsAbstractPaginatingDC<DataModel>)
}

extension NetworkDataReceiver where Self: NSObject {
    var itemCount: Int {
        return dataProvider?.itemList.count ?? 0
    }
    
    var itemList: [DataModel] {
        return dataProvider?.itemList ?? []
    }
    
    init(dataProvider: TVSeriesDetailsAbstractPaginatingDC<DataModel>) {
        self.init()
        self.dataProvider = dataProvider
    }
}
