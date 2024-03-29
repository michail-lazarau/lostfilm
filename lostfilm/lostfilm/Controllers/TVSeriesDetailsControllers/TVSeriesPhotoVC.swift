import SDWebImage
import UIKit

class TVSeriesPhotoVC: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!

    let model: LFPhotoModel?
    let thumbnailImg: UIImage

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, model: LFPhotoModel, image: UIImage) {
        thumbnailImg = image
        self.model = model
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class var nibName: String {
        String(describing: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.zoomScale = 1
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.image = thumbnailImg
//        scrollView.contentInsetAdjustmentBehavior = .never
// MARK: to figure out what is this for
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidingTabAndNavigationBars()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        settingUpImageView()
        UIView.animate(withDuration: 1, animations: {
            self.scrollView.zoomScale = self.scrollView.minimumZoomScale
        }, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }

    private func hidingTabAndNavigationBars() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func settingUpImageView() {
        // TODO: debug it with a weak internet connection once a special developer tool is available to download
        imageView.sd_setImage(with: model?.highResolutionImageUrl, placeholderImage: thumbnailImg, options: []) { (image, _, _, _)  in
            if let image = image {
                self.scrollView.zoomScale = self.scrollView.zoomScale * image.size.width / image.size.height

                    // TODO: animation for vertical images dont work yet
//                if image.size.height > image.size.width {
//                    self.imageView.clipsToBounds = true
//                    self.imageView.bounds.size = image.size
//                    self.imageView.frame.size = CGSize(width: image.size.width, height: image.size.width)
//
//                    UIView.animate(withDuration: 1, animations: {
//                        self.scrollView.frame.size = image.size
//                    }, completion: nil)
//                }

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

    // https://stackoverflow.com/questions/39460256/uiscrollview-zooming-contentinset
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
