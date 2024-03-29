//
//  DealershipVC.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

class DealershipVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator!
    var tableManager: DealershipTableManager!
    
}

// MARK: - Horizontal size class handling
extension DealershipVC {
    @objc func dismissModalVC() {
        coordinator.dismiss(self.navigationController)
    }
}

extension DealershipVC: Storyboarded {}
