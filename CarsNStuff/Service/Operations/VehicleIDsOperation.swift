//
//  VehicleIDsOperation.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/28/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class VehicleIDsOperation: Operation {
    typealias VehicleIDsHandler = (VehicleIDs?) -> ()
    
    private let urlSession: URLSession
    private let completionHandler: VehicleIDsHandler
    private var url: URL?
    private var vehicleIDs: VehicleIDs?
    var dataset: Dataset?
    
    init(_ urlSession: URLSession, completionHandler: @escaping VehicleIDsHandler) {
        self.urlSession = urlSession
        self.completionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        if isCancelled {
            print("\(#function): DatasetOperation is cancelled")
            return
        }
        
        // TODO: Graceful error handling
        guard let dataset = dataset else { return }
        
        let urlBuilder = URLBuilder(basePath: HttpConstants.basePath)
        guard let url = urlBuilder.getVehicleIDsURL(dataset) else { return }
        
        let vehicleIDsTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            self.vehicleIDs = JSONParser.decode(jsonData: data, into: VehicleIDs.self)
            print("\(self.vehicleIDs!)")
            self.completionHandler(self.vehicleIDs)
        }
        
        vehicleIDsTask.resume()
    }
}