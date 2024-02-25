//
//  WeatherModel.swift
//  Viper-Sample
//
//  Created by srbrt on 24.02.2024.
//

import Foundation

// MARK: - WeatherModel

struct WeatherModel: Codable {
    let lat, lon: Double?
    let timezone: String?
    let timezoneOffset: Int?

    let current: Current?
    let daily: [Daily]?
    let hourly: [Hourly]?
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, daily, hourly
    }
}

struct Hourly: Codable {
    let dt: Int?
    let temp: Double?
    let weather: [Weather]?
    enum CodingKeys: String, CodingKey {
        case dt, weather, temp
    }
}

// MARK: - Current

struct Current: Codable {
    let dt, sunrise, sunset: Int?
    let temp, feelsLike: Double?
    let pressure, humidity: Int?
    let dewPoint, uvi: Double?
    let clouds, visibility: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let weather: [Weather]?
    let windGust: Double?
    let pop: Int?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
        case windGust = "wind_gust"
        case pop
    }
}

// MARK: - Weather

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum Main: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Daily

struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Int?
    let moonset: Int?
    let moonPhase: Double?
    let temp: Temp?
    let feelsLike: FeelsLike?
    let pressure, humidity: Int?
    let dewPoint, windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let weather: [Weather]?
    let clouds: Int?
    let pop, uvi, rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi, rain
    }
}

// MARK: - FeelsLike

struct FeelsLike: Codable {
    let day, night, eve, morn: Double?
}

// MARK: - Temp

struct Temp: Codable {
    let day, min, max, night: Double?
    let eve, morn: Double?
}
