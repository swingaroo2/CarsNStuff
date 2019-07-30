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
    weak var coordinator: MainCoordinator!
    var coreDataManager: CoreDataManager!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addDealershipsNavButton()
    }
}

// MARK: - IBActions
extension InitialButtonVC {
    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        sender.disable()
        progressView.isHidden = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        coreDataManager.wipeClean()
        let taskManager = DataTaskManager(with: coreDataManager)
        
        taskManager.fetch() {
            DispatchQueue.main.async { [unowned self] in
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.progressView.isHidden = true
                self.coordinator.showDealerships()
                sender.enable(enabledColor: Colors.fetchButton)
            }
        }
    }
}

// MARK: - Private functions
private extension InitialButtonVC {
    private func addDealershipsNavButton() {
        let navButton = UIBarButtonItem(title: TitleConstants.dealerships, style: .plain, target: self, action: #selector(dealershipsNavButtonPressed))
        navButton.isEnabled = coreDataManager.hasEntities(named: ModelConstants.dealership)
        navigationItem.rightBarButtonItem = navButton
    }
    
    @objc private func dealershipsNavButtonPressed() {
        coordinator.showDealerships()
    }
}

// MARK: - Storyboarded
extension InitialButtonVC: Storyboarded {}
