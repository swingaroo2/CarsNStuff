//
//  AppDelegate.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import UIKit
import CoreData
import Network

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
    private var coordinator: MainCoordinator?
    private let coreDataManager = CoreDataManager(modelName: ModelConstants.modelName)
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navController = UINavigationController()
        initializeCoordinator(with: navController, coreDataManager: coreDataManager)
        window = UIWindow.createNewWindow(with: navController)
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreDataManager.save()
    }
}

private extension AppDelegate {
    func initializeCoordinator(with navController: UINavigationController, coreDataManager: CoreDataManager) {
        coordinator = MainCoordinator(navigationController: navController, coreDataManager: coreDataManager)
        coordinator?.start()
    }
}

