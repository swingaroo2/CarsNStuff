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
    @IBOutlet weak var progressView: UIView!
    weak var coordinator: MainCoordinator?
    var coreDataManager: CoreDataManager!
    
}

// MARK: - IBActions
extension InitialButtonVC {
    @IBAction func fetchButtonTapped() {
        progressView.isHidden = false
        coreDataManager.wipeClean()
        let taskManager = DataTaskManager(with: coreDataManager)
        
        taskManager.fetch() {
            DispatchQueue.main.async { [unowned self] in
                self.progressView.isHidden = true
                self.coordinator?.showDealerships()
            }
        }
    }
}

// MARK: - Storyboarded
extension InitialButtonVC: Storyboarded {}
