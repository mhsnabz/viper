//
//  Locations+CoreDataProperties.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//
//

import CoreData
import Foundation

public extension Locations {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Locations> {
        return NSFetchRequest<Locations>(entityName: "Locations")
    }

    @NSManaged var latitude: Double
    @NSManaged var longLatitude: Double
    @NSManaged var locationName: String?
    @NSManaged var locationId: String?
}

extension Locations: Identifiable {}
