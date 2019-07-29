//
//  CoreDataManager.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {

    var modelName: String
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        
        if let persistentStoreURL = container.persistentStoreDescriptions.first?.url {
            let description = NSPersistentStoreDescription(url: persistentStoreURL)
            description.shouldAddStoreAsynchronously = true
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        }
        return container
    }()

    init(modelName: String) {
        self.modelName = modelName
    }
}

// MARK: - Save
extension CoreDataManager {
    func save () {
        let context = persistentContainer.viewContext
        executeSave(in: context)
    }
}

// MARK: Create
extension CoreDataManager {
    func saveNewVehicle(from vehicleInfo: VehicleInfo) {
        persistentContainer.performBackgroundTask { [weak self] context in
            guard let self = self else { return }
            let newVehicle = Vehicle(context: context)
            newVehicle.vehicleId = vehicleInfo.vehicleId
            newVehicle.year = vehicleInfo.year
            newVehicle.make = vehicleInfo.make
            newVehicle.model = vehicleInfo.model
            newVehicle.dealerId = vehicleInfo.dealerId
            self.executeSave(in: context)
        }
    }
}

private extension CoreDataManager {
    func executeSave(in context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
                print("[CoreData] Saved!")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
