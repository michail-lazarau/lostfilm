import UIKit
import SDWebImage

class TVSeriesPhotoVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    weak var tabbarRootController = UIApplication.shared.windows.first?.rootViewController as? TabBarRootController
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, image: UIImage?) {
        self.image = image
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        viewTransitionSetup()
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
        imageView.image = image
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabbarRootController?.tabBar.isHidden = false
    }
    
    private func viewTransitionSetup() {
        imageView.sd_imageTransition = SDWebImageTransition.fade
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
}

extension TVSeriesPhotoVC: ImageViewZoomable {
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        imageView
    }
}
