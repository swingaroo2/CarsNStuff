//
//  HttpService.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/28/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class DataTaskManager {
    
    private var datasetID: String?
    private let coreDataManager: CoreDataManager
    
    init(with coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func fetch() {
        let queue = OperationQueue()
        let urlSession = URLSession(configuration: .default)
        
        let vehicleIDsOperation = VehicleIDsOperation(urlSession) { vehicleIDs in
            print("VehicleIDs completion block")
            vehicleIDs?.vehicleIds.forEach { vehicleID in
                let vehicleInfoOperation = VehicleInfoOperation(urlSession) { vehicles in
                    print("VehicleInfoOperation completion block")
                }
                vehicleInfoOperation.coreDataManager = self.coreDataManager
                vehicleInfoOperation.datasetID = self.datasetID
                vehicleInfoOperation.vehicleID = vehicleID
                queue.addOperation(vehicleInfoOperation)
            }
            
        }
        
        let datasetOperation = DatasetOperation(urlSession) { dataset in
            print("Dataset completion block")
            vehicleIDsOperation.datasetID = dataset?.datasetId
            self.datasetID = dataset?.datasetId
            queue.addOperation(vehicleIDsOperation)
        }
        
        queue.addOperation(datasetOperation)
    }
}
