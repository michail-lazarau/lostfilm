import UIKit
import SDWebImage

class TVSeriesPhotoVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    weak var tabbarRootController = UIApplication.shared.windows.first?.rootViewController as? TabBarRootController
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, image: UIImage?) {
        self.image = image
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
        imageView.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabbarRootController?.tabBar.isHidden = true
//        navigationController?.setToolbarHidden(true, animated: false)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabbarRootController?.tabBar.isHidden = false
    }
}

extension TVSeriesPhotoVC: ImageViewZoomable {
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        imageView
    }
}
