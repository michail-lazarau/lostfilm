import SDWebImage
import UIKit

class TVSeriesPhotoVC: UIViewController {
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    weak var tabbarRootController = UIApplication.shared.windows.first?.rootViewController as? TabBarRootController
    let model: LFPhotoModel?
    let thumbnailImg: UIImage

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, model: LFPhotoModel, image: UIImage) {
        thumbnailImg = image
        self.model = model
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class var nibName: String {
        String(describing: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false // MARK: what for?
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.image = thumbnailImg
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidingTabAndNavigationBars()
        settingUpImageVIew()
        // TODO: cпросить про кеширование! Идентифицируются ли файлы как одинаковые скачанные с помощью SDWebImage и URLSession.shared.downloadTask
        
        UIView.animate(withDuration: 1) {
            self.scrollView.zoomScale = self.scrollView.minimumZoomScale
        } completion: { (_) in
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabbarRootController?.tabBar.isHidden = false
    }

    private func hidingTabAndNavigationBars() {
        tabbarRootController?.tabBar.isHidden = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        navigationController?.navigationBar.isTranslucent = true // MARK: what for - no difference

        navigationController?.navigationBar.backgroundColor = .clear
    }

    private func settingUpImageVIew() {
        // TODO: debug it with a weak internet connection once a special developer tool is available to download
        imageView.contentMode = .scaleAspectFit // MARK: check if needed
        imageView.sd_setImage(with: model?.highResolutionImageUrl, placeholderImage: thumbnailImg, options: []) { (image, error, _, _)  in
            if let image = image {
                self.scrollView.zoomScale = self.scrollView.zoomScale * image.size.width / image.size.height
                UIView.animate(withDuration: 1) {
                    self.scrollView.zoomScale = self.scrollView.minimumZoomScale
                } completion: { (_) in
                }
            }
        }
    }

//
//    func updateMinZoomScaleForSize(_ size: CGSize) {
//      let widthScale = size.width / imageView.bounds.width
//      let heightScale = size.height / imageView.bounds.height
//      let minScale = min(widthScale, heightScale)
//
//      scrollView.minimumZoomScale = minScale
//      scrollView.zoomScale = minScale
//    }
    
//    override func viewWillLayoutSubviews() {
//      super.viewWillLayoutSubviews()
//      updateMinZoomScaleForSize(view.bounds.size)
//    }
//
//    //1
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//      updateConstraintsForSize(view.bounds.size)
//    }
//
//    //2
//    func updateConstraintsForSize(_ size: CGSize) {
//      //3
//      let yOffset = max(0, (size.height - imageView.frame.height) / 2)
//      imageViewTopConstraint.constant = yOffset
//      imageViewBottomConstraint.constant = yOffset
//
//      //4
//      let xOffset = max(0, (size.width - imageView.frame.width) / 2)
//      imageViewLeadingConstraint.constant = xOffset
//      imageViewTrailingConstraint.constant = xOffset
//
//      view.layoutIfNeeded()
//    }
}

extension TVSeriesPhotoVC: ImageViewZoomable {
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        return imageView
    }
}

extension TVSeriesPhotoVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
