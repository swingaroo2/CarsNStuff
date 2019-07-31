//
//  HttpService.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/28/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class DataTaskManager {
    typealias VoidCompletionHandler = () -> ()
    private var datasetID: String?
    private let coreDataManager: CoreDataManager
    private var vehicleSet: Set<VehicleInfo>
    private var dealershipSet: Set<DealershipInfo>
    
    init(with coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.vehicleSet = Set<VehicleInfo>()
        self.dealershipSet = Set<DealershipInfo>()
    }
    
    func updateModel(_ completion: @escaping VoidCompletionHandler) {
        coreDataManager.update(with: self.vehicleSet, self.dealershipSet, completion)
    }
    
    func fetch(completion: @escaping VoidCompletionHandler) {
        let queue = OperationQueue()
        let urlSession = URLSession(configuration: .default)
        let group = DispatchGroup()
        
        let vehicleIDsOperation = VehicleIDsOperation(urlSession) { vehicleIDs in
            vehicleIDs?.vehicleIds.forEach { vehicleID in
                group.enter()
                let vehicleInfoOperation = VehicleInfoOperation(urlSession) { vehicle in
                    guard let vehicle = vehicle else {
                        return
                    }
                    self.vehicleSet.insert(vehicle)
                    
                    let dealershipInfoOperation = DealershipInfoOperation(urlSession) { dealership in
                        group.leave()
                        guard let dealership = dealership else {
                            return
                        }
                        self.dealershipSet.insert(dealership)
                    }
                    
                    let dealershipID = vehicle.dealerId
                    dealershipInfoOperation.coreDataManager = self.coreDataManager
                    dealershipInfoOperation.datasetID = self.datasetID
                    dealershipInfoOperation.dealershipID = dealershipID
                    queue.addOperation(dealershipInfoOperation)
                }
                
                vehicleInfoOperation.coreDataManager = self.coreDataManager
                vehicleInfoOperation.datasetID = self.datasetID
                vehicleInfoOperation.vehicleID = vehicleID
                queue.addOperation(vehicleInfoOperation)
            }
            
            group.notify(queue: .main) {
                self.updateModel(completion)
            }
        }
        
        let datasetOperation = DatasetOperation(urlSession) { dataset in
            vehicleIDsOperation.datasetID = dataset?.datasetId
            self.datasetID = dataset?.datasetId
            queue.addOperation(vehicleIDsOperation)
        }
        
        queue.addOperation(datasetOperation)
    }
}
