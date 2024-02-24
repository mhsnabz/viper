//
//  WaetherInteractor.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import CoreLocation
import Foundation

/// The `WaetherInteractor` class is responsible for interacting with the weather service to fetch weather data.
final class WaetherInteractor {
    /// The weather service used to fetch weather data.
    private let service: WeatherService

    /// Initializes an instance of `WaetherInteractor`.
    /// - Parameter service: The weather service to use. Defaults to the shared instance of `WeatherService`.
    init(service: WeatherService = .shared) {
        self.service = service
    }
}

// MARK: - Extensions -

extension WaetherInteractor: WaetherInteractorInterface {
    /// Fetches the current weather data for the specified latitude and longitude coordinates.
    /// - Parameters:
    ///   - lat: The latitude of the location.
    ///   - longLat: The longitude of the location.
    ///   - completion: A closure to be called once the weather data is fetched, containing a `Result` with either the fetched weather data or an error.
    func getCurrentWeather(_ lat: Double, _ longLat: Double, _ completion: @escaping ((Result<WeatherModel, APIError>) -> Void)) {
        // Call the fetchWeather method of the weather service to retrieve weather data
        service.fetchWeather(latitude: lat, longitude: longLat) { result in
            // Pass the result to the completion closure
            completion(result)
        }
    }
}
