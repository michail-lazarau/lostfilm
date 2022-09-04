import Foundation

struct LFApplicationHelper {
    static private (set) var shared: LFApiHelper = {
        guard let instance = LFApiHelper.default() else { fatalError("LOL, be careful, drink a water") }
        return instance
    }()

    private init() {
    }
}
