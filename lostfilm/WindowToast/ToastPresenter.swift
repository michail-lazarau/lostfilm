import Foundation
import UIKit

public class ToastPresenter: ToastWindowProtocol {
    private var toastQueue = Queue<ToastWindow>()
    private(set) var activeToastWindow: ToastWindow?

    public static let shared = ToastPresenter()

    func enqueueToastForPresentation(_ toastWindow: ToastWindow) {
        toastQueue.enqueue(toastWindow)
        showNextAlertIfPresent()
    }

    public func enqueueToastForPresentation(toast: UIView, toastManager: ToastManager) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        let rootVC = ToastPresentingController(toast: toast, toastManager: toastManager)
        let toastWindow = ToastWindow(rootViewController: rootVC, windowScene: scene)

        enqueueToastForPresentation(toastWindow)
    }

    private func showNextAlertIfPresent() {
        guard activeToastWindow == nil, let toastWindow = toastQueue.dequeue() else {
            return
        }

        activeToastWindow = toastWindow
        (toastWindow.rootViewController as? ToastPresentingController)?.windowDelegate = self
        activeToastWindow?.makeKeyAndVisible()
    }

    func dismissWindow() {
        activeToastWindow = nil
        showNextAlertIfPresent()
    }
}
