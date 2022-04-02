import Foundation

protocol ImageViewZoomable {
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView?
}
