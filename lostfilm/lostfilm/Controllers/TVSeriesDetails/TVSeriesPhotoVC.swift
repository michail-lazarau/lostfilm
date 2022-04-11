import SDWebImage
import UIKit

class TVSeriesPhotoVC: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var model: LFPhotoModel?
    weak var tabbarRootController = UIApplication.shared.windows.first?.rootViewController as? TabBarRootController

//    var highResolutionImageView: UIImageView? {
//        didSet {
//            if let highResolutionImageUrl = model?.highResolutionImageUrl {
//                let highResolutionImageView = UIImageView()
//                highResolutionImageView.sd_setImage(with: highResolutionImageUrl)
//                return highResolutionImageView
//            } else {
//                return nil
//            }
//        }
//    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, model: LFPhotoModel) {
        self.model = model
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    class var nibName: String {
        String(describing: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabbarRootController?.tabBar.isHidden = true
        navigationController?.navigationBar.backgroundColor = .clear
        viewTransitionSetup()
        // TODO: cпросить про кеширование! Идентифицируются ли файлы как одинаковые скачанные с помощью SDWebImage и URLSession.shared.downloadTask
//        let placeholder: UIImageView = UIImageView(frame: <#T##CGRect#>)
//        UIImageView().sd_setImage(with: model?.url)
//        imageView.sd_setImage(with: model?.highResolutionImageUrl, placeholderImage: placeholder.image)
        imageView.sd_setImage(with: model?.highResolutionImageUrl)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabbarRootController?.tabBar.isHidden = false
    }

    private func viewTransitionSetup() {
        // TODO: debug it with a weak internet connection once a special developer tool is available to download
        imageView.sd_imageTransition = SDWebImageTransition.curlUp
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
    }
}

extension TVSeriesPhotoVC: ImageViewZoomable {
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        imageView
    }
}
