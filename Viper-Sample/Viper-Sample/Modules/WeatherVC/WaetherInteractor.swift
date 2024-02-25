//
//  WaetherInteractor.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import CoreLocation
import Foundation

/**
 The `WaetherInteractor` class is responsible for interacting with the weather service to fetch weather data.
 */
final class WaetherInteractor {
    /// The weather service used to fetch weather data.
    private let service: WeatherService

    /**
     Initializes an instance of `WaetherInteractor`.

     - Parameter service: The weather service to use. Defaults to the shared instance of `WeatherService`.
     */
    init(service: WeatherService = .shared) {
        self.service = service
    }
}

extension WaetherInteractor: WaetherInteractorInterface {
    /**
     Fetches the saved location data.

     - Parameter completion: A closure to be called once the saved locations are fetched, containing an optional array of `Locations`.
     */
    func getSavedLocation(_ completion: @escaping ([Locations]?) -> Void) {
        completion(service.getSavedLocations())
    }

    /**
     Fetches the current weather data for the specified latitude and longitude coordinates.

     - Parameters:
        - lat: The latitude of the location.
        - longLat: The longitude of the location.
        - type: The metric type for temperature (Celsius or Fahrenheit).
        - completion: A closure to be called once the weather data is fetched, containing a `Result` with either the fetched `WeatherModel` or an `APIError`.
     */
    func getCurrentWeather(_ lat: Double, _ longLat: Double, _ type: MetricType, _ completion: @escaping ((Result<WeatherModel, APIError>) -> Void)) {
        service.fetchWeather(latitude: lat, longitude: longLat, type: type) { result in
            completion(result)
        }
    }
}
