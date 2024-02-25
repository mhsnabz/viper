//
//  UILabel+Extension.swift
//  Viper-Sample
//
//  Created by srbrt on 24.02.2024.
//

import CoreLocation
import UIKit

// Extension to enhance UILabel functionality
extension UILabel {
    // Function to convert Unix timestamp to a human-readable date format
    func unixTimestampToDate(dt: Int, type: DateType = .onlyDay) {
        // Creating a Date object from the Unix timestamp
        let date = Date(timeIntervalSince1970: TimeInterval(dt))

        // Initializing a DateFormatter with the specified format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue

        // Formatting the Date object into a string representation
        let formattedDate = dateFormatter.string(from: date)

        // Updating the text of the UILabel instance with the formatted date
        text = formattedDate
    }

    // Function to retrieve the name of the current location based on latitude and longitude
    func getCurrentPlace(latitude: Double, longitude: Double) {
        var locationName = ""
        CLLocation.getCurrentPlace(latitude: latitude, longitude: longitude) { cityName in
            locationName += cityName ?? ""
            self.text = locationName
        } completionCounry: { countryName in
            locationName += ","
            locationName += countryName ?? ""
            self.text = locationName
        }
    }
}

// Enumeration to define different date formats
enum DateType: String {
    case onlyDay = "EEEE" // Display only the day of the week
    case hours = "HH:mm" // Display hours and minutes
    case fullDate = "dd/MM/yyyy HH:mm" // Display full date and time
}
