//
//  VehiclesVC.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/29/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import UIKit

class VehiclesVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator!
    var tableManager: VehiclesTableManager!
    var selectedDealerID: Int!
}

// MARK: - Horizontal size class handling
extension VehiclesVC {
    @objc func dismissModalVC() {
        coordinator.dismiss(self.navigationController)
    }
}

extension VehiclesVC: Storyboarded {}
