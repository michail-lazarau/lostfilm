import SDWebImage
import UIKit

class TVSeriesPhotoVC: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    weak var tabbarRootController = UIApplication.shared.windows.first?.rootViewController as? TabBarRootController
    let model: LFPhotoModel?

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, model: LFPhotoModel) {
        self.model = model
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        model = nil
        super.init(coder: coder)
    }

    class var nibName: String {
        String(describing: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false // what for?
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidingTabAndNavigationBars()
        settingUpImageVIew()
        // TODO: cпросить про кеширование! Идентифицируются ли файлы как одинаковые скачанные с помощью SDWebImage и URLSession.shared.downloadTask
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabbarRootController?.tabBar.isHidden = false
    }

    private func hidingTabAndNavigationBars() {
        tabbarRootController?.tabBar.isHidden = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true // MARK: no difference
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    private func settingUpImageVIew() {
        // TODO: debug it with a weak internet connection once a special developer tool is available to download
        imageView.sd_setImage(with: model?.highResolutionImageUrl)
        imageView.sd_imageTransition = SDWebImageTransition.curlUp
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        
        //        imageView.sd_setImage(with: model?.highResolutionImageUrl) { [weak self] (image, _, _, _) -> Void in
        //            self?.configureSizeAndZoomScale(image: image)
        //        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        scrollView.contentSize = imageView.intrinsicContentSize
//        scrollView.contentSize = imageView.intrinsicContentSize
    }

//    func configureSizeAndZoomScale(image: UIImage?) {
//        if let image = image {
//            imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
//            scrollView.addSubview(imageView)
//            scrollView.contentSize = image.size
//
//            let scrollViewFrame = scrollView.frame
//            let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
//            let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
//            let minScale = min(scaleWidth, scaleHeight)
//
//            scrollView.minimumZoomScale = minScale
//            scrollView.maximumZoomScale = 1.0
//            scrollView.zoomScale = minScale
//
//            centerScrollViewContents()
//        }
//    }
//
//    func centerScrollViewContents() {
//        let boundsSize = scrollView.bounds.size
//        var contentsFrame = imageView.frame
//
//        if contentsFrame.size.width < boundsSize.width {
//            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
//        } else {
//            contentsFrame.origin.x = 0.0
//        }
//
//        if contentsFrame.size.height < boundsSize.height {
//            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
//        } else {
//            contentsFrame.origin.y = 0.0
//        }
//
//        imageView.frame = contentsFrame
//    }
}

extension TVSeriesPhotoVC: ImageViewZoomable {
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        imageView
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        centerScrollViewContents()
//    }
}

extension TVSeriesPhotoVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
