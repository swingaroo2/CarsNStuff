//
//  Dealership+CoreDataProperties.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/29/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//
//

import Foundation
import CoreData


extension Dealership {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dealership> {
        return NSFetchRequest<Dealership>(entityName: "Dealership")
    }

    @NSManaged public var dealerId: Int64
    @NSManaged public var name: String
    @NSManaged public var vehicles: NSSet?

}

// MARK: Generated accessors for vehicles
extension Dealership {

    @objc(addVehiclesObject:)
    @NSManaged public func addToVehicles(_ value: Vehicle)

    @objc(removeVehiclesObject:)
    @NSManaged public func removeFromVehicles(_ value: Vehicle)

    @objc(addVehicles:)
    @NSManaged public func addToVehicles(_ values: NSSet)

    @objc(removeVehicles:)
    @NSManaged public func removeFromVehicles(_ values: NSSet)

}
