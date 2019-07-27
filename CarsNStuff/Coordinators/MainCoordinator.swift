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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let initialButtonVC = InitialButtonVC.instantiate()
        initialButtonVC.coordinator = self
        navigationController.pushViewController(initialButtonVC, animated: false)
    }
}

// MARK: Navigation functions
extension MainCoordinator {
    func showDealerships() {
        print(#function)
    }
    
    // TODO: Pass a ManagedObject, or relevant property
    func showVehiclesForDealership() {
        print(#function)
    }
}
