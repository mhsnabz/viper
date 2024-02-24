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
        // Creating a CLLocation object with the provided coordinates
        let location = CLLocation(latitude: latitude, longitude: longitude)

        // Initializing a CLGeocoder instance to perform reverse geocoding
        let geocoder = CLGeocoder()

        // Performing reverse geocoding to obtain the location name
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            // Handling any potential errors during reverse geocoding
            print("error: \(error?.localizedDescription)")

            // String to store the extracted location name
            var locationName = ""

            // Extracting location information from the first placemark
            guard let placemark = placemarks?.first else {
                // If no placemark is available, update the label with "Unknown Location"
                self.text = "Unknown Location"
                return
            }
            if let locality = placemark.locality {
                locationName += locality
            }
            if let adminArea = placemark.administrativeArea {
                if !locationName.isEmpty {
                    locationName += ", "
                }
                locationName += adminArea
            }
            if let country = placemark.country {
                if !locationName.isEmpty {
                    locationName += ", "
                }
                locationName += country
            }

            // Updating the text of the UILabel instance with the obtained location name
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
