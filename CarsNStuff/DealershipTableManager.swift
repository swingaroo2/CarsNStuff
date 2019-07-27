//
//  DealershipDataSource.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

class DealershipTableManager: NSObject {
    
    var dealerships = [String]()
    var coreDataManager: CoreDataManager!
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

extension DealershipTableManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealerships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Placeholder
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.generic, for: indexPath)
        let dealership = dealerships[indexPath.row]
        cell.textLabel?.text = dealership
        return cell
    }
}

extension DealershipTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Back to the coordinator")
    }
}
