import Foundation

class ToastPresenter: AlertWindowProtocol {
    private var toastQueue = Queue<AlertWindow>()
    private(set) var activeToastWindow: AlertWindow?

    static let shared = ToastPresenter()

    func enqueueToastForPresentation(_ alertWindow: AlertWindow) {
        toastQueue.enqueue(alertWindow)

        showNextAlertIfPresent()
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
