//
//  SplashViewController.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import CoreLocation
import UIKit

/// View controller responsible for displaying the splash screen.
final class SplashViewController: UIViewController {
    // MARK: - Public properties -

    /// Presenter responsible for handling interactions and business logic for the splash screen.
    var presenter: SplashPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        // Call the presenter to fetch the user's location when the view loads
        presenter.getLocation()
    }
}

// MARK: - Extensions -

/// Extension conforming to the `SplashViewInterface` protocol,
/// providing necessary methods for interacting with the splash view.
extension SplashViewController: SplashViewInterface {}
