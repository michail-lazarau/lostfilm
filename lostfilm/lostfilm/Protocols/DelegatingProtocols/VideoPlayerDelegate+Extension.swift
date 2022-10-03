import Foundation
import AVKit

protocol VideoPlayerDelegate: AnyObject {
    func launchVideo(by url: URL)
}

extension VideoPlayerDelegate where Self: UIViewController {
    func launchVideo(by url: URL) {
        let vc = AVPlayerViewController()
        vc.player = AVPlayer(url: url)
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
}
