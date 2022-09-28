import Foundation

class GlobalSearchPersonsItem: GlobalSearchItem {
    var type: GlobalSearchItemType {
        return .persons
    }

    var rowCount: Int {
        persons.count
    }
    private let persons: [LFPersonModel]

    init(personList: [LFPersonModel]) {
        persons = personList
    }
}

extension GlobalSearchPersonsItem {
    subscript(index: Int) -> LFPersonModel {
        persons[index]
    }
}
