import Foundation

protocol Router: Routable {
    var parent: RouterDelegate? { get set }
    func start() -> UIViewController
}

protocol Routable: AnyObject {
    func route(to viewController: UIViewController, as transition: Transition)
    func route(to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?)

    func route(to router: Router, using transition: Transition)
    func route(to router: Router, using transition: Transition, completion: (() -> Void)?)
}

protocol Closable: AnyObject {
    func close()
    func close(completion: (() -> Void)?)
}

protocol Dismissable: AnyObject {
    /// Dismisses the Router's root view controller ignoring the transition used to show it.
    func dismiss()
    func dismiss(completion: (() -> Void)?)
}
