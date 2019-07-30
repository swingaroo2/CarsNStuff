//
//  VehiclesTableViewCell.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/29/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

class VehiclesTableViewCell: UITableViewCell {
    @IBOutlet weak var yearMakeModelLabel: UILabel!
    @IBOutlet weak var vehicleIDLabel: UILabel!
    @IBOutlet weak var dealershipIDLabel: UILabel!
    
    class func configure(_ cell: VehiclesTableViewCell, with vehicle: Vehicle) {
        cell.yearMakeModelLabel.text = "\(vehicle.year) \(vehicle.make) \(vehicle.model)"
        cell.vehicleIDLabel.text = "Vehicle ID: \(vehicle.vehicleId)"
        cell.dealershipIDLabel.text = "Dealership ID: \(vehicle.dealerId)"
    }
}
