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
    var initialImageViewFrame: CGRect?
    var initialPictureSize: CGSize?


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
        navigationController?.navigationBar.isHidden = false // what for?
//        imageView.sd_imageTransition = SDWebImageTransition.fade // what for?
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.image = thumbnailImg
//        settingUpImageVIew()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidingTabAndNavigationBars()
        settingUpImageVIew()
        // TODO: cпросить про кеширование! Идентифицируются ли файлы как одинаковые скачанные с помощью SDWebImage и URLSession.shared.downloadTask
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1) {
            self.scrollView.zoomScale = self.scrollView.minimumZoomScale
        } completion: { (_) in
            //
//            self.imageView.image  = self.resizedImage(at: self.imageView.image!, for: self.initialPictureSize!)
            //
//            self.imageView.frame = self.initialImageViewFrame ?? .zero
        }
//        self.scrollView.setZoomScale(1.0, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabbarRootController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.scrollView.zoomScale = 1;
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
        //
//        SDWebImageManager.shared.loadImage(with: model?.highResolutionImageUrl, progress: nil) { [weak self] image, _, error, _, _, _ in
//            guard let self = self else { return }
//            guard error == nil else { return }
//            if let image = image {
//                let imageAspectRatio = image.size.width / image.size.height
//                let defaultSizedImg = self.resizedImage(at: image, for: CGSize(width: UIScreen.main.bounds.width * imageAspectRatio, height: UIScreen.main.bounds.width))
//                self.imageView.image = defaultSizedImg
//            }
//        }
        //
        imageView.contentMode = .scaleAspectFit
//        imageView.image = thumbnailImg
//        imageView.sd_setImage(with: model?.highResolutionImageUrl, placeholderImage: thumbnailImg)
        //
        imageView.sd_setImage(with: model?.highResolutionImageUrl, placeholderImage: thumbnailImg, options: []) { (image, error, _, _)  in
            if let image = image {
//                self.initialImageViewFrame = self.imageView.frame
                //
//                self.initialPictureSize = image.size
                //
                self.scrollView.zoomScale = self.scrollView.zoomScale * image.size.width / image.size.height
            }
        }
        
        //
//        SDWebImageManager.shared.loadImage(with: model?.highResolutionImageUrl, progress: nil) { [weak self] image, _, error, _, _, _ in
//            guard let self = self else { return }
//            guard error == nil else { return }
//            if let image = image {
//                UIView.transition(with: self.imageView, duration: 3.0, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
//                    self.imageView.image = image
//                }, completion: nil)
//            }
//        }
        
        //
//        imageView.sd_imageTransition = SDWebImageTransition.fade
//        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge

        //        imageView.sd_setImage(with: model?.highResolutionImageUrl) { [weak self] (image, _, _, _) -> Void in
        //            self?.configureSizeAndZoomScale(image: image)
        //        }
    }

    func resizedImage(at image: UIImage, for size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
      let widthScale = size.width / imageView.bounds.width
      let heightScale = size.height / imageView.bounds.height
      let minScale = min(widthScale, heightScale)
        
      scrollView.minimumZoomScale = minScale
      scrollView.zoomScale = minScale
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      updateMinZoomScaleForSize(view.bounds.size)
    }
    
    //1
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
      updateConstraintsForSize(view.bounds.size)
    }

    //2
    func updateConstraintsForSize(_ size: CGSize) {
      //3
      let yOffset = max(0, (size.height - imageView.frame.height) / 2)
      imageViewTopConstraint.constant = yOffset
      imageViewBottomConstraint.constant = yOffset
      
      //4
      let xOffset = max(0, (size.width - imageView.frame.width) / 2)
      imageViewLeadingConstraint.constant = xOffset
      imageViewTrailingConstraint.constant = xOffset
        
      view.layoutIfNeeded()
    }
}

extension TVSeriesPhotoVC: ImageViewZoomable {
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
//        imageView.transform = CGAffineTransform.identity
        //        self.scrollView.zoomScale = self.scrollView.zoomScale / (imageView.image!.size.width / imageView.image!.size.height)
        return imageView
    }
}

extension TVSeriesPhotoVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
