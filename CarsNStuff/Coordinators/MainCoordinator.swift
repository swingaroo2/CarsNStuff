//
//  MainCoordinator.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var coreDataManager: CoreDataManager
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManager) {
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
    }
    
    func start() {
        let initialButtonVC = InitialButtonVC.instantiate()
        initialButtonVC.coordinator = self
        initialButtonVC.coreDataManager = coreDataManager
        navigationController.pushViewController(initialButtonVC, animated: false)
    }
}

// MARK: Navigation functions
extension MainCoordinator {
    func showDealerships() {
        let dealershipVC = DealershipVC.instantiate()
        dealershipVC.coordinator = self
        dealershipVC.tableManager = DealershipTableManager(coreDataManager: coreDataManager)
        navigationController.pushViewController(dealershipVC, animated: true)
    }
    
    // TODO: Pass a ManagedObject, or relevant property
    func showVehicleIDsForDealership() {
        print(#function)
    }
}
