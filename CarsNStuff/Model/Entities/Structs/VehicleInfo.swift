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
}
