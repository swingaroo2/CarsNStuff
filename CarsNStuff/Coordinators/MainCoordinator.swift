//
//  MainCoordinator.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//
//  Inspiration for the Coordinator pattern courtesy of Paul Hudson (Hacking with Swift)

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
        initialButtonVC.title = TitleConstants.fetchData
        navigationController.pushViewController(initialButtonVC, animated: false)
    }
}

// MARK: Navigation functions
extension MainCoordinator {
    func showDealerships() {
        let dealershipVC = DealershipVC.instantiate()
        dealershipVC.title = TitleConstants.dealerships
        dealershipVC.coordinator = self
        dealershipVC.loadViewIfNeeded()
        dealershipVC.tableManager = DealershipTableManager(for: dealershipVC, coreDataManager: coreDataManager)
        
        let isHorizontalRegular = UIScreen.main.traitCollection.horizontalSizeClass == .regular
        if isHorizontalRegular {
            let newNavController = UINavigationController(rootViewController: dealershipVC)
            newNavController.modalPresentationStyle = .formSheet
            
            let dismissButton = UIBarButtonItem(title: TitleConstants.dismiss, style: .plain, target: dealershipVC, action: #selector(DealershipVC.dismissModalVC))
            
            dealershipVC.navigationItem.rightBarButtonItem = dismissButton
            
            navigationController.present(newNavController, animated: true, completion: nil)
        } else {
            navigationController.pushViewController(dealershipVC, animated: true)
        }
        
    }
    
    func showVehicles(for selectedDealership: Dealership) {
        let vehiclesVC = VehiclesVC.instantiate()
        vehiclesVC.title = selectedDealership.name
        vehiclesVC.coordinator = self
        vehiclesVC.loadViewIfNeeded()
        vehiclesVC.tableManager = VehiclesTableManager(for: vehiclesVC, coreDataManager: coreDataManager)
        vehiclesVC.selectedDealerID = Int(selectedDealership.dealerId)
        
        let isHorizontalRegular = UIScreen.main.traitCollection.horizontalSizeClass == .regular
        var presentingVC = navigationController
        
        if isHorizontalRegular {
            guard let modalDealershipsVC = navigationController.presentedViewController as? UINavigationController else { return }
            let dismissButton = UIBarButtonItem(title: TitleConstants.dismiss, style: .plain, target: vehiclesVC, action: #selector(VehiclesVC.dismissModalVC))
            vehiclesVC.navigationItem.rightBarButtonItem = dismissButton
            presentingVC = modalDealershipsVC
        }
        
        presentingVC.pushViewController(vehiclesVC, animated: true)
    }
    
    func dismiss(_ viewController: UIViewController?) {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
