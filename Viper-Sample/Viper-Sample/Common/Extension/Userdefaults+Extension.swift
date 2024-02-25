//
//  Userdefaults+Extension.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//

import Foundation
extension UserDefaults {
    enum keys: String {
        case latitude
        case longLatitude
    }

    class func setLatitude(_ latitude: Double) {
        standard.setValue(latitude, forKey: keys.latitude.rawValue)
    }

    class func getLatitude() -> Double {
        standard.double(forKey: keys.latitude.rawValue)
    }

    class func setLongLatiude(_ longLatitude: Double) {
        standard.setValue(longLatitude, forKey: keys.longLatitude.rawValue)
    }

    class func getLongLatitude() -> Double {
        standard.double(forKey: keys.longLatitude.rawValue)
    }
}
