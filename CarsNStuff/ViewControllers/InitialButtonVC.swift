//
//  InitialButtonVC.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import UIKit

class InitialButtonVC: UIViewController {
    
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    var coreDataManager: CoreDataManager!
}

// MARK: - IBActions
extension InitialButtonVC {
    @IBAction func fetchButtonTapped() {
        let appHttpService = DataTaskManager()
        appHttpService.fetch()
        
        // TODO: call this in a completion handler.
//        coordinator?.showDealerships()
    }
}

// MARK: - Storyboarded
extension InitialButtonVC: Storyboarded {}
