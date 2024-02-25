//
//  CoreLocation+Extension.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//

import CoreLocation
import Foundation
extension CLLocation {
    // Function to retrieve the name of the current location based on latitude and longitude
    class func getCurrentPlace(latitude: Double, longitude: Double, completionCity: @escaping (_ cityName: String?) -> Void, completionCounry: @escaping (_ countryName: String?) -> Void) {
        // Creating a CLLocation object with the provided coordinates
        let location = CLLocation(latitude: latitude, longitude: longitude)

        // Initializing a CLGeocoder instance to perform reverse geocoding
        let geocoder = CLGeocoder()

        // Performing reverse geocoding to obtain the location name
        geocoder.reverseGeocodeLocation(location) { placemarks, _ in

            // Extracting location information from the first placemark
            guard let placemark = placemarks?.first else {
                // If no placemark is available, update the label with "Unknown Location"
                return
            }
            if let locality = placemark.locality {
                completionCity(locality)
            }
            if let country = placemark.country {
                completionCounry(country)
            }
        }
    }
}
