import Foundation

class BaseDataProvider {
    let modelId: String
    var apiHelper: LFApiHelper {
        LFApplicationHelper.shared
    }

    init(modelId: String) {
        self.modelId = modelId
    }
}
