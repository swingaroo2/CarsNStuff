//
//  HttpService.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/28/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class HttpService {
    
    func fetch() {
        let queue = OperationQueue()
        let urlSession = URLSession(configuration: .default)
        
        let vehicleIDsOperation = VehicleIDsOperation(urlSession) { vehicleIDs in
            print("VehicleIDs completion block")
        }
        
        let datasetOperation = DatasetOperation(urlSession) { dataset in
            print("Dataset completion block")
            vehicleIDsOperation.dataset = dataset
            queue.addOperation(vehicleIDsOperation)
        }
        
        queue.addOperation(datasetOperation)
    }
}
