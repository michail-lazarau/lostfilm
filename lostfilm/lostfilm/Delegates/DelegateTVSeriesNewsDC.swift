import Foundation

protocol DelegateTVSeriesNewsDC: AnyObject {
    func updateTableViewWith(newsList: [LFNewsModel])
}
