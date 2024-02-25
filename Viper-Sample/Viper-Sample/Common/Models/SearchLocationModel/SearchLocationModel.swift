//
//  SearchLocationModel.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//

import Foundation

// MARK: - SearchLocationModel

struct SearchLocationModel: Codable {
    let lat, lon, name, displayName: String?

    enum CodingKeys: String, CodingKey {
        case lat, lon, name
        case displayName = "display_name"
    }
}
