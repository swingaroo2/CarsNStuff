//
//  VehicleInfo.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/28/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

struct VehicleInfo: Codable {
    var vehicleId: Int
    var year: Int
    var make: String
    var model: String
    var dealerId: Int
}
