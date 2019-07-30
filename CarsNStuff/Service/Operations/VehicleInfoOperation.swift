//
//  VehicleInfoOperation.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/28/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class VehicleInfoOperation: Operation {
    typealias VehicleInfoHandler = (VehicleInfo?) -> ()
    
    private let urlSession: URLSession
    private let completionHandler: VehicleInfoHandler
    var coreDataManager: CoreDataManager!
    var vehicleInfo: VehicleInfo?
    var datasetID: String?
    var vehicleID: Int?
    
    init(_ urlSession: URLSession, completionHandler: @escaping VehicleInfoHandler) {
        self.urlSession = urlSession
        self.completionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        if isCancelled {
            print("\(#function): VehicleInfoOperation is cancelled")
            return
        }
        
        
        let urlBuilder = URLBuilder(basePath: HttpConstants.basePath)
        guard let datasetID = datasetID, let vehicleID = vehicleID else { return }
        guard let url = urlBuilder.getVehicleInfoURL(datasetID, vehicleID) else { return }
        
        let vehicleInfoTask = urlSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            self.vehicleInfo = JSONParser.decode(jsonData: data, into: VehicleInfo.self)
            
            guard let vehicleInfo = self.vehicleInfo else { return }
            self.completionHandler(vehicleInfo)
        }
        
        vehicleInfoTask.resume()
    }
}
