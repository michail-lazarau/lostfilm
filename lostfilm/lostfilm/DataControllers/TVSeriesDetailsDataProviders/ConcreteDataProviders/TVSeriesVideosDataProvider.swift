import Foundation

final class TVSeriesVideosDataProvider: BaseDataProvider, IHaveDataModelFetchedByPage {
    func fetchData(page number: UInt, completionHandler: @escaping ([LFVideoModel]?, NSError?) -> Void) {
        apiHelper.series.getVideoListForSeries(byId: modelId, page: number) { videoList, error in
            completionHandler(videoList, error as NSError?)
        }
    }
}
