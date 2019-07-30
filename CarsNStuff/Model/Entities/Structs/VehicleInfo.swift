//
//  VehicleInfo.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/28/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

struct VehicleInfo: Codable, Hashable {
    var vehicleId: Int64
    var year: Int64
    var make: String
    var model: String
    var dealerId: Int64
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(year)
        hasher.combine(make)
        hasher.combine(model)
        hasher.combine(vehicleId)
        hasher.combine(dealerId)
    }
    
    static func ==(lhs: VehicleInfo, rhs: VehicleInfo) -> Bool {
        let isEqual = lhs.year == rhs.year && lhs.make == rhs.make &&
                      lhs.model == rhs.model && lhs.vehicleId == rhs.vehicleId &&
                      lhs.dealerId == rhs.dealerId
        return isEqual
    }
}
