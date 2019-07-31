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
    typealias VoidCompletionHandler = () -> ()
    weak var dealershipsDelegate: NSFetchedResultsControllerDelegate?
    var modelName: String
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        }
        return container
    }()
    
    lazy var dealershipFRC: NSFetchedResultsController<Dealership> = {
        let fetchRequest: NSFetchRequest<Dealership> = Dealership.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: ModelConstants.name, ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: persistentContainer.viewContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        frc.delegate = self.dealershipsDelegate
        try? frc.performFetch()
        
        return frc
    }()
    
    lazy private var vehicleFRC: NSFetchedResultsController<Vehicle> = {
        let fetchRequest: NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: ModelConstants.year, ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: persistentContainer.viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return frc
    }()

    init(modelName: String) {
        self.modelName = modelName
    }
}

// MARK: Fetching
extension CoreDataManager {
    func hasEntities(named entityName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let entitesCount = try? persistentContainer.viewContext.count(for: fetchRequest)
        return (entitesCount ?? 0) > 0
    }
    
    func fetchVehicles(for dealerID: Int) -> [Vehicle] {
        vehicleFRC.fetchRequest.predicate = NSPredicate(format: Predicates.hasDealerID, argumentArray: [dealerID])
        
        do {
            try vehicleFRC.performFetch()
        } catch {
            print("Error \(error.localizedDescription)")
        }
        
        let fetchedObjects = vehicleFRC.fetchedObjects ?? [Vehicle]()
        return fetchedObjects
    }
    
    func fetchVehicle(for dealerID: Int, at indexPath: IndexPath) -> Vehicle {
        let fetchedVehicles = fetchVehicles(for: dealerID)
        let chosenVehicle = fetchedVehicles[indexPath.row]
        return chosenVehicle
    }
}

// MARK: - Save/Delete/Update
extension CoreDataManager {
    func save() {
        let context = persistentContainer.viewContext
        executeSave(in: context)
    }
    
    // NOTE: Prevents storage overload from pulling a new dataset (with new vehicleIDs and dealerIDs)
    //       Normally, I would expect the remote DB to have consistent vehicle and dealer IDs
    func wipeClean() {
        deleteAllRecords(entityName: ModelConstants.vehicle)
        deleteAllRecords(entityName: ModelConstants.dealership)
    }
    
    func update(with vehicles: Set<VehicleInfo>,_ dealerships: Set<DealershipInfo>,_ completion: @escaping VoidCompletionHandler) {
        persistentContainer.performBackgroundTask { [weak self] context in
            dealerships.forEach { dealershipInfo in
                guard let self = self else { return }
                let newDealership = self.createNewDealership(from: dealershipInfo, in: context)
                let ownedVehicles = vehicles.filter { newDealership.dealerId == $0.dealerId }
                self.add(ownedVehicles, to: newDealership, in: context)
                self.executeSave(in: context)
            }
            completion()
        }
    }
}

// MARK: Private functions
private extension CoreDataManager {
    func executeSave(in context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("[CoreData] Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteAllRecords(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let moc = persistentContainer.viewContext
            let results = try moc.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else { continue }
                moc.delete(objectData)
                save()
            }
        } catch let error {
            print("Failed to delete all data in \(entityName) error :", error)
        }
    }
    
    func add(_ ownedVehicles: Set<VehicleInfo>, to dealership: Dealership, in context: NSManagedObjectContext) {
        let ownedVehicleMOs = ownedVehicles.map { self.createNewVehicle(from: $0, in: context, with: dealership) }
        let vehicleSet = NSSet(array: ownedVehicleMOs)
        dealership.addToVehicles(vehicleSet)
    }
    
    func createNewVehicle(from vehicleInfo: VehicleInfo, in context: NSManagedObjectContext, with dealership: Dealership) -> Vehicle {
        let newVehicle = Vehicle(context: context)
        newVehicle.vehicleId = vehicleInfo.vehicleId
        newVehicle.year = vehicleInfo.year
        newVehicle.make = vehicleInfo.make
        newVehicle.model = vehicleInfo.model
        newVehicle.dealerId = vehicleInfo.dealerId
        newVehicle.dealership = dealership
        return newVehicle
    }
    
    private func createNewDealership(from dealershipInfo: DealershipInfo, in context: NSManagedObjectContext) -> Dealership {
        let newDealership = Dealership(context: context)
        newDealership.dealerId = dealershipInfo.dealerId
        newDealership.name = dealershipInfo.name
        return newDealership
    }
}
