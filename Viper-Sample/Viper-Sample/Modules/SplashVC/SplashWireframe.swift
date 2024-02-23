//
//  SplashWireframe.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import UIKit

/// Class responsible for coordinating navigation and module setup for the splash screen.
final class SplashWireframe: BaseWireframe<SplashViewController> {

    // MARK: - Module setup -

    /// Initializes the splash wireframe and sets up the module.
    init() {
        let moduleViewController = SplashViewController()
        super.init(viewController: moduleViewController)

        // Create instances of necessary dependencies
        let formatter = SplashFormatter()
        let interactor = SplashInteractor()

        // Create presenter with dependencies
        let presenter = SplashPresenter(view: moduleViewController, formatter: formatter, interactor: interactor, wireframe: self)

        // Connect presenter to view controller
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

/// Extension conforming to the `SplashWireframeInterface` protocol,
/// providing necessary methods for coordinating navigation in the splash screen wireframe.
extension SplashWireframe: SplashWireframeInterface {

    /// Navigates to the main module.
    func navigateToMain() {
        // Create instance of the wireframe for the weather module
        let weatherWireframe = WaetherWireframe()
        
        // Present the weather module wireframe from the splash screen view controller
        self.viewController.presentWireframe(weatherWireframe, animated: true)
    }
}
