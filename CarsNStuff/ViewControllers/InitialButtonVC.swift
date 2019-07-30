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
    @IBOutlet weak var fetchButton: UIButton!
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
        fadeInProgressView()
        coreDataManager.wipeClean()
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let taskManager = DataTaskManager(with: coreDataManager)
        
        taskManager.fetch() {
            DispatchQueue.main.async { [unowned self] in
                self.fadeOutProgressView()
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.coordinator.showDealerships()
            }
        }
    }
}

// MARK: - Private functions
private extension InitialButtonVC {
    private func fadeInProgressView() {
        UIView.animate(withDuration: 0.2) {
            self.fetchButton.alpha = 0.0
            self.progressView.alpha = 1.0
        }
    }
    
    private func fadeOutProgressView() {
        UIView.animate(withDuration: 0.2) {
            self.fetchButton.alpha = 1.0
            self.progressView.alpha = 0.0
        }
    }
    
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
