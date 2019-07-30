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
    
    var dealerships = [String]()
    var coreDataManager: CoreDataManager!
    var tableView: UITableView
    
    init(for tableView: UITableView, coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.tableView = tableView
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
        let fetchedDealerships = coreDataManager.dealershipFRC.object(at: indexPath)
        cell.textLabel?.text = fetchedDealerships.name
        cell.detailTextLabel?.text = "\(fetchedDealerships.dealerId)"
        return cell
    }
}

extension DealershipTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Back to the coordinator")
    }
}

extension DealershipTableManager: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
            break;
        default:
            print("\(#function): Unhandled case")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
