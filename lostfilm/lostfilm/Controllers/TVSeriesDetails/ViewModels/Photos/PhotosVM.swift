import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class PhotosVM: NSObject {
    var itemCount: Int {
        return dataProvider?.itemList.count ?? 0
    }
    var photoList: [LFPhotoModel] {
        return dataProvider?.itemList ?? []
    }
    
    var dataProvider: TVSeriesPhotosDC?
    
    init(dataProvider: TVSeriesPhotosDC) {
        super.init()
        self.dataProvider = dataProvider
    }
}
