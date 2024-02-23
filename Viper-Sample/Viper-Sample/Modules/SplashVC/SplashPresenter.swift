//
//  SplashPresenter.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import Foundation
import CoreLocation

/// Presenter responsible for handling business logic and interactions for the splash screen.
final class SplashPresenter: CLLocationManager, CLLocationManagerDelegate {
    
    // MARK: - Private properties -
    
    /// Location manager for managing location-related tasks.
    private var locationManager = CLLocationManager()
    
    /// Reference to the view interface for the splash screen.
    private unowned let view: SplashViewInterface
    
    /// Formatter interface for formatting data in the splash screen.
    private let formatter: SplashFormatterInterface
    
    /// Interactor interface for handling business logic in the splash screen.
    private let interactor: SplashInteractorInterface
    
    /// Wireframe interface for coordinating navigation in the splash screen.
    private let wireframe: SplashWireframeInterface

    // MARK: - Lifecycle -

    /// Initializes the splash presenter with dependencies.
    init(view: SplashViewInterface, formatter: SplashFormatterInterface, interactor: SplashInteractorInterface, wireframe: SplashWireframeInterface) {
        self.view = view
        self.formatter = formatter
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - CLLocationManagerDelegate methods -

    /// Called when the location manager receives updated location information.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Check if the location information is available
        if let location = locations.first {
            // Navigate to the main module if location is available
            wireframe.navigateToMain()
        }
    }
    
    /// Called when the location manager encounters an error while fetching location.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Retry fetching location if an error occurs
        getLocation()
    }
}

// MARK: - Extensions -

/// Extension conforming to the `SplashPresenterInterface` protocol,
/// providing necessary methods for interacting with the splash presenter.
extension SplashPresenter: SplashPresenterInterface {
    
    /// Requests the user's location.
    func getLocation() {
        // Set the delegate to receive location updates
        self.locationManager.delegate = self
        // Request permission to use location services when the app is in use
        self.locationManager.requestWhenInUseAuthorization()
        // Request location updates
        self.locationManager.requestLocation()
    }
       
}
