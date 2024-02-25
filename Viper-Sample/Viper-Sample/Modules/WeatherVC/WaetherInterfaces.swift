//
//  WaetherInterfaces.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//

import CoreLocation
import UIKit

// Protocol defining the interface for the weather module wireframe
protocol WaetherWireframeInterface: WireframeInterface {}

// Protocol defining the interface for the weather module view
protocol WaetherViewInterface: ViewInterface {
    /// Function to reload the list of weather data
    /// - Parameter model: The weather model to display
    func reloadList(_ model: WeatherModel?)
}

// Protocol defining the interface for the weather module presenter
protocol WeatherPresenterInterface: PresenterInterface {
    /// Function to request weather data from the API
    /// - Parameters:
    ///   - lat: The latitude value of the location
    ///   - longLat: The longitude value of the location
    func requestApi(_ lat: Double, longLat: Double)

    /// Function to retrieve the daily weather item at a specific index path
    /// - Parameter indexPath: The index path of the item
    /// - Returns: The Daily object at the specified index path
    func item(at indexPath: IndexPath) -> Daily?

    /// Function to retrieve the hourly weather item at a specific index path
    /// - Parameter indexPath: The index path of the item
    /// - Returns: The Hourly object at the specified index path
    func itemAtHourly(at indexPath: IndexPath) -> Hourly?

    /// Function to get the number of rows in the weather section
    /// - Returns: The number of rows
    func numberOfRowInSection() -> Int

    /// Function to get the number of rows in the saved locations section
    /// - Returns: The number of rows
    func locationsNumberOfRowInSection() -> Int

    /// Function to retrieve the location item at a specific index path
    /// - Parameter indexPath: The index path of the item
    /// - Returns: The Locations object at the specified index path
    func locationItem(at indexPath: IndexPath) -> Locations?

    /// Function to get the data source for locations
    /// - Returns: An array of Locations objects representing the saved locations
    func getLocationDataSource() -> [Locations]
}

// Protocol defining the interface for the weather module formatter
protocol WaetherFormatterInterface: FormatterInterface {}

// Protocol defining the interface for the weather module interactor
protocol WaetherInteractorInterface: InteractorInterface {
    /// Function to fetch current weather data based on latitude and longitude
    /// - Parameters:
    ///   - lat: The latitude value of the location
    ///   - longLat: The longitude value of the location
    ///   - completion: A closure where the weather data will be returned or an error if the request fails
    func getCurrentWeather(_ lat: Double, _ longLat: Double, _ completion: @escaping ((Result<WeatherModel, APIError>) -> Void))

    /// Function to retrieve saved locations from Core Data
    /// - Parameter completion: A closure where the array of Locations objects representing the saved locations will be returned
    func getSavedLocation(_ completion: @escaping ([Locations]?) -> Void)
}
