//
//  InitialButtonVC.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import UIKit
import Network

class InitialButtonVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var fetchButton: UIButton!
    
    weak var coordinator: MainCoordinator!
    var coreDataManager: CoreDataManager!
    
    private let monitor = NWPathMonitor()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let networkStatusQueue = DispatchQueue(label: GeneralConstants.connectionMonitor)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addDealershipsNavButton()
        monitorNetworkStatus()
    }
}

// MARK: - IBActions
extension InitialButtonVC {
    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        sender.fadeOut(for: progressView)
        coreDataManager.wipeClean()
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let taskManager = DataTaskManager(with: coreDataManager)
        taskManager.fetch() {
            DispatchQueue.main.async { [unowned self] in
                self.progressView.fadeOut(for: sender)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.coordinator.showDealerships()
            }
        }
    }
}

// MARK: - Private functions
private extension InitialButtonVC {
    func setFetchButtonState(for connectionStatus: Bool) {
        let backgroundColor = connectionStatus ? Colors.fetchButton : .lightGray
        let titleColor: UIColor = connectionStatus ? .darkText : .lightText
        let title = connectionStatus ? ButtonTitles.fetchButtonNormal : ButtonTitles.fetchButtonNoInternetConnection
        self.fetchButton.handle(connectionStatus, backgroundColor: backgroundColor, titleColor: titleColor, title: title)
    }
    
    func monitorNetworkStatus() {
        monitor.pathUpdateHandler = { [unowned self] pathUpdateHandler in
            DispatchQueue.main.async {
                let hasInternetConnection = pathUpdateHandler.status == .satisfied
                self.setFetchButtonState(for: hasInternetConnection)
            }
        }
        
        monitor.start(queue: networkStatusQueue)
    }
    
    func presentAlert(with title: String?, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: AlertConstants.ok, style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func addDealershipsNavButton() {
        let navButton = UIBarButtonItem(title: ButtonTitles.navButtonStoredData, style: .plain, target: self, action: #selector(dealershipsNavButtonPressed))
        navButton.isEnabled = coreDataManager.hasEntities(named: ModelConstants.dealership)
        navigationItem.rightBarButtonItem = navButton
    }
    
    @objc func dealershipsNavButtonPressed() {
        coordinator.showDealerships()
    }
}

// MARK: - Storyboarded
extension InitialButtonVC: Storyboarded {}
