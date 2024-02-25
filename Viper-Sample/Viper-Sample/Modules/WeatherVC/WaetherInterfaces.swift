//
//  WaetherInterfaces.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//

import CoreLocation
import UIKit

/// Protocol defining the interface for the weather module wireframe.
protocol WaetherWireframeInterface: WireframeInterface {}

/// Protocol defining the interface for the weather module view.
protocol WaetherViewInterface: ViewInterface {
    /// Reloads the list of weather data.
    /// - Parameter model: The weather model to display.
    func reloadList(_ model: WeatherModel?)
}

/// Protocol defining the interface for the weather module presenter.
protocol WeatherPresenterInterface: PresenterInterface {
    /// Requests weather data from the API.
    /// - Parameters:
    ///   - lat: The latitude value of the location.
    ///   - longLat: The longitude value of the location.
    ///   - type: The type of metric system to use (e.g., metric or imperial).
    func requestApi(_ lat: Double, longLat: Double, type: MetricType)

    /// Retrieves the daily weather item at a specific index path.
    /// - Parameter indexPath: The index path of the item.
    /// - Returns: The Daily object at the specified index path.
    func item(at indexPath: IndexPath) -> Daily?

    /// Retrieves the hourly weather item at a specific index path.
    /// - Parameter indexPath: The index path of the item.
    /// - Returns: The Hourly object at the specified index path.
    func itemAtHourly(at indexPath: IndexPath) -> Hourly?

    /// Gets the number of rows in the weather section.
    /// - Returns: The number of rows.
    func numberOfRowInSection() -> Int

    /// Gets the number of rows in the saved locations section.
    /// - Returns: The number of rows.
    func locationsNumberOfRowInSection() -> Int

    /// Retrieves the location item at a specific index path.
    /// - Parameter indexPath: The index path of the item.
    /// - Returns: The Locations object at the specified index path.
    func locationItem(at indexPath: IndexPath) -> Locations?

    /// Gets the data source for locations.
    /// - Returns: An array of Locations objects representing the saved locations.
    func getLocationDataSource() -> [Locations]
}

/// Protocol defining the interface for the weather module formatter.
protocol WaetherFormatterInterface: FormatterInterface {}

/// Protocol defining the interface for the weather module interactor.
protocol WaetherInteractorInterface: InteractorInterface {
    /// Fetches current weather data based on latitude and longitude.
    /// - Parameters:
    ///   - lat: The latitude value of the location.
    ///   - longLat: The longitude value of the location.
    ///   - type: The type of metric system to use
    ///   - completion: A closure where the weather data will be returned or an error if the request fails.
    func getCurrentWeather(_ lat: Double, _ longLat: Double, _ type: MetricType, _ completion: @escaping ((Result<WeatherModel, APIError>) -> Void))

    /// Retrieves saved locations from Core Data.
    /// - Parameter completion: A closure where the array of Locations objects representing the saved locations will be returned.
    func getSavedLocation(_ completion: @escaping ([Locations]?) -> Void)
}
