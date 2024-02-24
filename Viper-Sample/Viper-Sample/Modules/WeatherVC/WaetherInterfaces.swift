//
//  WaetherInterfaces.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import CoreLocation
import UIKit

// Protocol defining the interface for the weather module wireframe
protocol WaetherWireframeInterface: WireframeInterface {}

// Protocol defining the interface for the weather module view
protocol WaetherViewInterface: ViewInterface {
    // Function to reload the list of weather data
    func reloadList(_ model: WeatherModel?)
}

// Protocol defining the interface for the weather module presenter
protocol WaetherPresenterInterface: PresenterInterface {
    // Function to request weather data from the API
    func requestApi(_ lat: Double, longLat: Double)

    // Function to retrieve the daily weather item at a specific index path
    func item(at indexPath: IndexPath) -> Daily?
}

// Protocol defining the interface for the weather module formatter
protocol WaetherFormatterInterface: FormatterInterface {}

// Protocol defining the interface for the weather module interactor
protocol WaetherInteractorInterface: InteractorInterface {
    // Function to fetch current weather data based on latitude and longitude
    func getCurrentWeather(_ lat: Double, _ longLat: Double, _ completion: @escaping ((Result<WeatherModel, APIError>) -> Void))
}
