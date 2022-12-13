import Foundation

protocol RouterDelegate: AnyObject {
    func shouldCompleteRouter(_ router: DefaultRouter)
}

class DefaultRouter: NSObject, Router, Closable, Dismissable, RouterDelegate {

    private let rootTransition: Transition
    weak var root: UIViewController?
    weak var parent: RouterDelegate?

    init(rootTransition: Transition) {
        self.rootTransition = rootTransition
    }

    func start() -> UIViewController {
        fatalError("Need to be overridden")
    }

    deinit {
        print("🗑 Deallocating \(self) with \(String(describing: rootTransition))")
    }

    // MARK: - Routable

    func route(to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?) {
        guard let root = root else { return }
        transition.open(viewController, from: root, completion: completion)
    }

    func route(to viewController: UIViewController, as transition: Transition) {
        route(to: viewController, as: transition, completion: nil)
    }

    func route(to router: Router, using transition: Transition) {
        guard let root = root else { return }
        router.parent = self
        transition.open(router.start(), from: root, completion: nil)
    }

    func route(to router: Router, using transition: Transition, completion: (() -> Void)?) {
        router.parent = self
        route(to: router.start(), as: transition, completion: completion)
    }

    // MARK: - Closable

    func close(completion: (() -> Void)?) {
        guard let root = root else { return }
        // Removes the `root` with the same transition that it was opened.
        rootTransition.close(root, completion: completion)
    }

    func close() {
        close(completion: nil)
    }

    // MARK: - Dismissable

    func dismiss(completion: (() -> Void)?) {
        // Dismiss the root with iOS' default dismiss animation.
        // It will only work if the root or its ancestor were presented
        // using iOS' native present view controller method.
        root?.dismiss(animated: rootTransition.isAnimated, completion: completion)
    }

    func dismiss() {
        parent?.shouldCompleteRouter(self)
    }

    // MARK: - RouterDelegate

    func shouldCompleteRouter(_ router: DefaultRouter) {
        dismiss()
    }
}
