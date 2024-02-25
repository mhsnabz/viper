//
//  WaetherPresenter.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//

import Foundation

/// The `WaetherPresenter` class acts as the presenter component in the VIPER architecture pattern.
final class WaetherPresenter {
    // MARK: - Private properties -

    /// The reference to the view interface.
    private unowned let view: WaetherViewInterface

    /// The reference to the formatter interface.
    private let formatter: WaetherFormatterInterface

    /// The reference to the interactor interface.
    private let interactor: WaetherInteractorInterface

    /// The reference to the wireframe interface.
    private let wireframe: WaetherWireframeInterface

    /// The weather model containing weather data.
    private var model: WeatherModel?

    /// The array containing daily weather data.
    private var dailyWeather: [Daily] = []

    /// The array containing hourly weather data.
    private var hourlyWeather: [Hourly] = []

    /// The array containing saved locations data.
    private var locations: [Locations] = []

    // MARK: - Lifecycle -

    /// Initializes an instance of `WaetherPresenter`.
    /// - Parameters:
    ///   - view: The view interface.
    ///   - formatter: The formatter interface.
    ///   - interactor: The interactor interface.
    ///   - wireframe: The wireframe interface.
    init(view: WaetherViewInterface, formatter: WaetherFormatterInterface, interactor: WaetherInteractorInterface, wireframe: WaetherWireframeInterface) {
        self.view = view
        self.formatter = formatter
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension WaetherPresenter: WeatherPresenterInterface {
    /// Retrieves the data source for locations.
    func getLocationDataSource() -> [Locations] {
        return locations
    }

    /// Requests weather data from the interactor.
    /// - Parameters:
    ///   - lat: The latitude.
    ///   - longLat: The longitude.
    ///   - type: The type of metric system to use (e.g., metric or imperial).
    func requestApi(_ lat: Double, longLat: Double, type: MetricType) {
        // Notify the view that data loading is in progress
        view.isLoading()

        // Call the interactor to fetch weather data
        interactor.getCurrentWeather(lat, longLat, type) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(success):
                // Handle success case
                self.model = success
                if let items = success.daily {
                    self.dailyWeather = items
                }
                if let items = success.hourly {
                    self.hourlyWeather = items
                }
                // Reload the view with the fetched weather data
                self.view.reloadList(success)
                view.stopLoading()
            case let .failure(failure):
                // Handle failure case (e.g., show alert)
                view.stopLoading()
            }
        }

        // Fetch saved locations from the interactor
        interactor.getSavedLocation { [weak self] model in
            if let model = model {
                self?.locations = model
            }
        }
    }

    /// Retrieves the daily weather item at the specified index path.
    /// - Parameter indexPath: The index path of the item.
    /// - Returns: The daily weather item at the specified index path, if available.
    func item(at indexPath: IndexPath) -> Daily? {
        if !dailyWeather.isEmpty {
            return dailyWeather[indexPath.row]
        }
        return nil
    }

    /// Retrieves the hourly weather item at the specified index path.
    /// - Parameter indexPath: The index path of the item.
    /// - Returns: The hourly weather item at the specified index path, if available.
    func itemAtHourly(at indexPath: IndexPath) -> Hourly? {
        if !hourlyWeather.isEmpty {
            return hourlyWeather[indexPath.row]
        }
        return nil
    }

    /// Retrieves the number of rows in the hourly weather section.
    func numberOfRowInSection() -> Int {
        return hourlyWeather.count
    }

    /// Retrieves the number of rows in the saved locations section.
    func locationsNumberOfRowInSection() -> Int {
        return locations.count
    }

    /// Retrieves the location item at the specified index path.
    /// - Parameter indexPath: The index path of the item.
    /// - Returns: The location item at the specified index path, if available.
    func locationItem(at indexPath: IndexPath) -> Locations? {
        if !locations.isEmpty {
            return locations[indexPath.row]
        }
        return nil
    }
}
