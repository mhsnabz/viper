//
//  WeatherService.swift
//  Viper-Sample
//
//  Created by srbrt on 24.02.2024.
//

import Foundation

/// This class represents a service used to fetch weather data.
class WeatherService {
    /// Returns a shared instance of the WeatherService class.
    static let shared = WeatherService()

    /// Fetches weather data for a location with specific latitude and longitude.
    /// - Parameters:
    ///   - latitude: The latitude value of the location.
    ///   - longitude: The longitude value of the location.
    ///   - completion: A closure where the weather data will be returned.
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
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }

    /// Generates the cURL command for the API request.
    /// - Parameters:
    ///   - latitude: The latitude value of the location.
    ///   - longitude: The longitude value of the location.
    ///   - apiKey: The API key for OpenWeatherMap.
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
    /// - Returns: The constructed URL or nil.
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
