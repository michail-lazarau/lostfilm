import UIKit

class CustomNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition: ZoomTransitioningDelegate?
        switch (fromVC, toVC) {
        case (_, is TVSeriesPhotoVC):
            transition = ZoomTransitioningDelegate()
            transition?.operation = .push
        case (is TVSeriesPhotoVC, _):
            transition = ZoomTransitioningDelegate()
            transition?.operation = .pop
        default:
            transition = nil
        }
        return transition
    }
}
