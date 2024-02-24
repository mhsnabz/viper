//
//  WireframeInterface.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
import UIKit

protocol WireframeInterface: AnyObject {}

/// Base class for wireframes, responsible for managing view controllers in the VIPER architecture.
///
/// The `BaseWireframe` class provides basic functionality for handling view controllers in a VIPER architecture.
/// It holds a weak reference to the view controller to prevent retain cycles.
/// The weak reference is stored in the `_viewController` property, and it's retained upon first access
/// by temporarily storing it in the `temporaryStoredViewController` property.
/// After the first access, the `_viewController` property is set to `nil` to break the reference cycle.
class BaseWireframe<ViewController> where ViewController: UIViewController {
    private weak var _viewController: ViewController?

    // We need it in order to retain the view controller reference upon first access
    private var temporaryStoredViewController: ViewController?

    /// Initializes the wireframe with the specified view controller.
    ///
    /// - Parameter viewController: The view controller associated with the wireframe.
    init(viewController: ViewController) {
        temporaryStoredViewController = viewController
        _viewController = viewController
    }
}

extension BaseWireframe {
    /// Returns the view controller associated with the wireframe.
    ///
    /// If the view controller is deallocated, accessing this property will raise a fatal error,
    /// providing guidance on how to correctly use the property.
    var viewController: ViewController {
        defer { temporaryStoredViewController = nil }
        guard let vc = _viewController else {
            fatalError(
                """
                The `ViewController` instance that the `_viewController` property holds
                was already deallocated in a previous access to the `viewController` computed property.

                If you don't store the `ViewController` instance as a strong reference
                at the call site of the `viewController` computed property,
                there is no guarantee that the `ViewController` instance won't be deallocated since the
                `_viewController` property has a weak reference to the `ViewController` instance.

                For the correct usage of this computed property, make sure to keep a strong reference
                to the `ViewController` instance that it returns.
                """
            )
        }
        return vc
    }

    /// Returns the navigation controller associated with the wireframe's view controller.
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
}

extension UIViewController {
    /// Presents the view controller associated with the specified wireframe.
    ///
    /// - Parameters:
    ///   - wireframe: The wireframe whose view controller to present.
    ///   - animated: A Boolean value indicating whether the presentation should be animated.
    ///   - completion: The block to execute after the presentation finishes.
    func presentWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true, completion: (() -> Void)? = nil) {
        let vc = wireframe.viewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    /// Pushes the view controller associated with the specified wireframe onto the navigation stack.
    ///
    /// - Parameters:
    ///   - wireframe: The wireframe whose view controller to push.
    ///   - animated: A Boolean value indicating whether the push operation should be animated.
    func pushWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true) {
        pushViewController(wireframe.viewController, animated: animated)
    }

    /// Sets the root view controller of the navigation stack to the view controller associated with the specified wireframe.
    ///
    /// - Parameters:
    ///   - wireframe: The wireframe whose view controller to set as the root.
    ///   - animated: A Boolean value indicating whether the transition to the root view controller should be animated.
    func setRootWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true) {
        setViewControllers([wireframe.viewController], animated: animated)
    }
}
