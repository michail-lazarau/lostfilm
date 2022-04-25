import SDWebImage
import UIKit

class TVSeriesPhotoVC: UIViewController {
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
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.image = thumbnailImg
//        scrollView.contentInsetAdjustmentBehavior = .never //MARK: to figure out what is this for
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidingTabAndNavigationBars()
        settingUpImageView()
        UIView.animate(withDuration: 1, animations: {
            self.scrollView.zoomScale = self.scrollView.minimumZoomScale
        }, completion: nil)
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
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    private func settingUpImageView() {
        // TODO: debug it with a weak internet connection once a special developer tool is available to download
        imageView.sd_setImage(with: model?.highResolutionImageUrl, placeholderImage: thumbnailImg, options: []) { (image, error, _, _)  in
            if let image = image {
                self.scrollView.zoomScale = self.scrollView.zoomScale * image.size.width / image.size.height
                UIView.animate(withDuration: 1, animations: {
                    self.scrollView.zoomScale = self.scrollView.minimumZoomScale
                }, completion: nil)
            }
        }
    }
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
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {

            if let image = imageView.image {

                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height

                let ratio = ratioW < ratioH ? ratioW:ratioH

                let newWidth = image.size.width*ratio
                let newHeight = image.size.height*ratio

                let left = 0.5 * (newWidth * scrollView.zoomScale > imageView.frame.width ? (newWidth - imageView.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
                let top = 0.5 * (newHeight * scrollView.zoomScale > imageView.frame.height ? (newHeight - imageView.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))

                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
