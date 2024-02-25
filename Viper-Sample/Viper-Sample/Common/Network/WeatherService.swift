//
//  WeatherService.swift
//  Viper-Sample
//
//  Created by srbrt on 24.02.2024.
//

import CoreData
import Foundation
import UIKit

/// This class represents a service used to fetch weather data from an API.
class WeatherService {
    /// Core Data context for managing location data.
    private var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    /// Returns a shared instance of the WeatherService class.
    static let shared = WeatherService()

    /// Fetches weather data for a location with specific latitude and longitude from the OpenWeatherMap API.
    /// - Parameters:
    ///   - latitude: The latitude value of the location.
    ///   - longitude: The longitude value of the location.
    ///   - completion: A closure where the weather data will be returned or an error if the request fails.
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherModel, APIError>) -> Void) {
        guard let url = buildURL(latitude: latitude, longitude: longitude) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard (200 ... 299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponseCode(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                // Convert JSON data to WeatherModel
                let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(weatherData))
            } catch {
                print("error :\(error.localizedDescription)")
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }

    /// Generates the cURL command for the API request based on the given latitude and longitude.
    /// - Parameters:
    ///   - latitude: The latitude value of the location.
    ///   - longitude: The longitude value of the location.
    ///   - apiKey: The API key for OpenWeatherMap (unused in the implementation).
    func fetchWeatherCurl(latitude: Double, longitude: Double, apiKey _: String) {
        guard let url = buildURL(latitude: latitude, longitude: longitude) else {
            return
        }
        print("curl :\(url)")
    }

    /// Builds the URL for the API request based on the given latitude and longitude.
    /// - Parameters:
    ///   - latitude: The latitude value of the location.
    ///   - longitude: The longitude value of the location.
    /// - Returns: The constructed URL or nil if the URL cannot be constructed.
    private func buildURL(latitude: Double, longitude: Double) -> URL? {
        var components = URLComponents(string: ApiConstant.baseURL)
        components?.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: ApiConstant.apiKey),
        ]
        return components?.url
    }

    /// Retrieves saved locations from Core Data.
    /// - Returns: An array of Locations objects representing the saved locations, or nil if an error occurs.
    func getSavedLocations() -> [Locations]? {
        guard let context = context else { return nil }
        let fetchRequest = NSFetchRequest<Locations>(entityName: "Locations")
        do {
            let locaitonsArray = try context.fetch(fetchRequest)
            return locaitonsArray
        } catch {
            return nil
        }
    }

    /// Saves a location to Core Data.
    /// - Parameters:
    ///   - latitude: The latitude value of the location.
    ///   - longLatitude: The longitude value of the location.
    ///   - locationName: The name of the location.
    func saveLocation(latitude: Double, longLatitude: Double, locationName: String) {
        guard let context = context else { return }
        let locationId = "\(latitude),\(longLatitude)"
        let fetch = NSFetchRequest<Locations>(entityName: "Locations")
        fetch.predicate = NSPredicate(format: "locationId == %@", locationId)
        fetch.fetchLimit = 1
        do {
            let location = try context.fetch(fetch)
            if location.isEmpty {
                guard let newLocation = NSEntityDescription.insertNewObject(forEntityName: "Locations", into: context) as? Locations else { return }
                newLocation.locationId = locationId
                newLocation.latitude = latitude
                newLocation.longLatitude = longLatitude
                newLocation.locationName = locationName
                saveContext()
            } else {
                location[0].locationId = locationId
                location[0].latitude = latitude
                location[0].longLatitude = longLatitude
                location[0].locationName = locationName
                saveContext()
            }

        } catch {}
    }

    /// Saves changes to the Core Data context.
    private func saveContext() {
        guard let context = context else { return }
        if context.hasChanges {
            do {
                try context.save()
            } catch {}
        }
    }
}

/// Enum representing API error types.
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidResponseCode(Int)
    case invalidData
    case decodingError(Error)
    case networkError(Error)
}
