import Foundation

class ToastPresenter: ToastWindowProtocol {
    private var toastQueue = Queue<ToastWindow>()
    private(set) var activeToastWindow: ToastWindow?

    static let shared = ToastPresenter()

    func enqueueToastForPresentation(_ toastWindow: ToastWindow) {
        toastQueue.enqueue(toastWindow)
        showNextAlertIfPresent()
    }

    func enqueueToastForPresentation(toast: UIButton, position: ToastPosition) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        let rootVC = ToastPresentingController(toast: toast, position: position)
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
