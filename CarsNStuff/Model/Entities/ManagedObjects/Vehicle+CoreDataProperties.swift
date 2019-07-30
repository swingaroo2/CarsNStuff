//
//  Vehicle+CoreDataProperties.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/29/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//
//

import Foundation
import CoreData


extension Vehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }

    @NSManaged public var vehicleId: Int64
    @NSManaged public var year: Int64
    @NSManaged public var make: String
    @NSManaged public var model: String
    @NSManaged public var dealerId: Int64
    @NSManaged public var dealership: Dealership

}
