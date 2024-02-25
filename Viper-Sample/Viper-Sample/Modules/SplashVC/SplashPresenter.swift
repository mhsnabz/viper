//
//  SplashPresenter.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import CoreLocation
import Foundation

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
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Check if the location information is available
        if let location = locations.first {
            let lat = Double(String(format: "%.2f", location.coordinate.latitude)) ?? 0
            let longLat = Double(String(format: "%.2f", location.coordinate.longitude)) ?? 0
            // Navigate to the main module if location is available
            UserDefaults.setLatitude(lat)
            UserDefaults.setLongLatiude(longLat)
            CLLocation.getCurrentPlace(latitude: lat, longitude: longLat) { [weak self] cityName in
                WeatherService.shared.saveLocation(latitude: lat, longLatitude: longLat, locationName: cityName ?? "Unknown Place")
                self?.wireframe.navigateToMain()
            } completionCounry: { _ in
            }
        }
    }

    /// Called when the location manager encounters an error while fetching location.
    func locationManager(_: CLLocationManager, didFailWithError _: Error) {
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
        locationManager.delegate = self
        // Request permission to use location services when the app is in use
        locationManager.requestWhenInUseAuthorization()
        // Request location updates
        locationManager.requestLocation()
    }
}
