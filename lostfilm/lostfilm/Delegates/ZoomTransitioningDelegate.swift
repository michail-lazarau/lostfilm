import Foundation
import UIKit

class ZoomTransitioningDelegate: NSObject {
    var transitionDuration = 0.5
    var operation: UINavigationController.Operation = .none
//    private let zoomScale = CGFloat(15)
    private let backgroundScale = CGFloat(0.7)
    
    func configureViews(for state: ImageViewTransitionState, containerView: UIView, fromViewController: UIViewController, fromImageView: UIImageView, toImageView: UIImageView, snapshotView: UIImageView) {
        switch state {
        case .initial:
            fromViewController.view.transform = CGAffineTransform.identity
            fromViewController.view.alpha = 1
            snapshotView.frame = containerView.convert(fromImageView.frame, from: fromImageView.superview)
        case .final:
            fromViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            fromViewController.view.alpha = 0
            snapshotView.frame = containerView.convert(toImageView.frame, from: toImageView.superview)
        }
    }
}

extension ZoomTransitioningDelegate: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        var preTransitionState = ImageViewTransitionState.initial
        var postTransitionState = ImageViewTransitionState.final
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        
        guard var fromVC = transitionContext.viewController(forKey: .from), var toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.viewController(forKey: .from) != nil ? fatalError("Cannot find fromVC") : fatalError("Cannot find toVC")
        }
        
        if operation == .pop {
//            containerView.bringSubviewToFront(fromVC.view)
            let temp = fromVC
            fromVC = toVC
            toVC = temp
            
            preTransitionState = .final
            postTransitionState = .initial
        }
        
        guard let fromImageView = (fromVC as? ImageViewZoomable)?.zoomingImageView(for: self), let toImageView = (toVC as? ImageViewZoomable)?.zoomingImageView(for: self) else {
            fromVC is ImageViewZoomable ? fatalError("fromVC is not ImageViewZoomable protocol compliant") : fatalError("toVC is not ImageViewZoomable protocol compliant")
        }
        
        fromImageView.isHidden = true
        toImageView.isHidden = true
        
        let imageViewSnapshot = UIImageView(image: fromImageView.image)
        imageViewSnapshot.contentMode = .scaleAspectFill //different option?
        imageViewSnapshot.layer.masksToBounds = true //remove?
        
        let toVCBackgroundColor = toVC.view.backgroundColor
        toVC.view.backgroundColor = .clear
        containerView.backgroundColor = .white
        
        containerView.addSubview(fromVC.view)
        containerView.addSubview(toVC.view)
        containerView.addSubview(imageViewSnapshot)
        
        configureViews(for: preTransitionState, containerView: containerView, fromViewController: fromVC, fromImageView: fromImageView, toImageView: toImageView, snapshotView: imageViewSnapshot)
        toVC.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: []) {[weak self] in
            guard let self = self else {
                return
            }
            self.configureViews(for: postTransitionState, containerView: containerView, fromViewController: fromVC, fromImageView: fromImageView, toImageView: toImageView, snapshotView: imageViewSnapshot)
        } completion: { (finished) in
            fromVC.view.transform = CGAffineTransform.identity
            imageViewSnapshot.removeFromSuperview()
            fromImageView.isHidden = false
            toImageView.isHidden = false
            
            toVC.view.backgroundColor = toVCBackgroundColor
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        transitionDuration
    }
}

//extension ZoomTransitioningDelegate: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        self.operation = operation
//        return self
//    }
//}
