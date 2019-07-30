//
//  DealershipDataSource.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DealershipTableManager: NSObject {
    
    private let coreDataManager: CoreDataManager!
    private let dealershipVC: DealershipVC
    
    init(for dealershipVC: DealershipVC, coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.dealershipVC = dealershipVC
        super.init()
        self.coreDataManager.dealershipsDelegate = self
    }
}

extension DealershipTableManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchedDealerships = coreDataManager.dealershipFRC.fetchedObjects
        let fetchedCount = fetchedDealerships?.count ?? 0
        return fetchedCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Placeholder
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.generic, for: indexPath)
        let fetchedDealership = coreDataManager.dealershipFRC.object(at: indexPath)
        configure(cell, with: fetchedDealership)
        return cell
    }
    
    private func configure(_ cell: UITableViewCell, with dealership: Dealership) {
        cell.textLabel?.text = dealership.name
        cell.detailTextLabel?.text = "ID: \(dealership.dealerId)"
    }
}

extension DealershipTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.isSelected = false
        let selectedDealership = coreDataManager.dealershipFRC.object(at: indexPath)
        let selectedDealerID = Int(selectedDealership.dealerId)
        dealershipVC.coordinator.showVehicles(for: selectedDealerID)
    }
}

// TODO: Might not even need this.
extension DealershipTableManager: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                dealershipVC.tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                dealershipVC.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = indexPath {
                dealershipVC.tableView.reloadRows(at: [indexPath], with: .fade)
            }
            break;
        default:
            print("\(#function): Unhandled case")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dealershipVC.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dealershipVC.tableView.endUpdates()
    }
}
