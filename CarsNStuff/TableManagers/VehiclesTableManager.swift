//
//  VehiclesTableManager.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/29/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class VehiclesTableManager: NSObject {
    
    private let coreDataManager: CoreDataManager!
    private let vehiclesVC: VehiclesVC
    private var selectedDealerID: Int!
    
    init(for vehiclesVC: VehiclesVC, coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.vehiclesVC = vehiclesVC
        super.init()
    }
}

extension VehiclesTableManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchedVehicles = coreDataManager.fetchVehicles(for: vehiclesVC.selectedDealerID)
        return fetchedVehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.generic, for: indexPath)
        let fetchedVehicle = coreDataManager.fetchVehicle(for: vehiclesVC.selectedDealerID, at: indexPath)
        configure(cell, with: fetchedVehicle)
        return cell
    }
    
    private func configure(_ cell: UITableViewCell, with vehicle: Vehicle) {
        print(#function)
    }
}

extension VehiclesTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.isSelected = false
    }
}
