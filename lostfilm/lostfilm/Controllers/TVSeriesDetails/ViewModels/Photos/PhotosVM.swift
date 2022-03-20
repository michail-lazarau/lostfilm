import Foundation

// NSObject inheritance is required for conforming UITableViewDataSource
class PhotosVM: NSObject {
    var itemCount: Int {
        return dataProvider?.photoList.count ?? 0
    }
    var photoList: [LFPhotoModel] {
        return dataProvider?.photoList ?? []
    }
    
    var dataProvider: TVSeriesPhotosDC?
    
    override init() {
        super.init()
    }
    
    init(dataProvider: TVSeriesPhotosDC) {
        super.init()
        self.dataProvider = dataProvider
    }
}
