import Foundation

class GlobalSearchVM: NSObject {
    let dataProvider: GlobalSearchDC
    
    var itemsForSections = [GlobalSearchItem]()
    
    init(dataProvider: GlobalSearchDC) {
        self.dataProvider = dataProvider
    }
    
    func fetchDataItems() {
        if let seriesList = dataProvider.seriesList {
            let seriesItem = GlobalSearchSeriesItem(seriesList: seriesList)
            itemsForSections.append(seriesItem)
        }
        
        if let personList = dataProvider.personList {
            let personsItem = GlobalSearchPersonsItem(personList: personList)
            itemsForSections.append(personsItem)
        }
    }
}
