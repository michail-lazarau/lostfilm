import Foundation

final class NewsDetailsDataProvider: BaseDataProvider, IHaveDataModelFetchedOnce {
    func fetchData(completionHandler: @escaping (LFNewsModel?, NSError?) -> Void) {
        apiHelper.news.getDetailsForNews(byId: modelId) { newsModel, error in
            completionHandler(newsModel, error as NSError?)
        }
    }
}
