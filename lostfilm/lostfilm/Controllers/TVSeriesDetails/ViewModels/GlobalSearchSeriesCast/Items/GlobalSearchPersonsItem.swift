import Foundation

class GlobalSearchPersonsItem: GlobalSearchItem {
    var type: GlobalSearchItemType {
        return .persons
    }
    
    var rowCount: Int {
        persons.count
    }
    let persons: [LFPersonModel]
    
    init(personList: [LFPersonModel]) {
        persons = personList
    }
}
