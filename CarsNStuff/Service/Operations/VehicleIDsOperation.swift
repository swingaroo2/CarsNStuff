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
    private var vehicleIDs: VehicleIDs?
    var datasetID: String?
    
    init(_ urlSession: URLSession, completionHandler: @escaping VehicleIDsHandler) {
        self.urlSession = urlSession
        self.completionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        if isCancelled {
            print("\(#function): VehicleIDsOperation is cancelled")
            return
        }
        
        
        let urlBuilder = URLBuilder(basePath: HttpConstants.basePath)
        guard let datasetID = datasetID else { return }        
        guard let url = urlBuilder.getVehicleIDsURL(datasetID) else { return }
        
        let httpClient = HttpClient(urlSession)
        httpClient.get(url) { data, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            self.vehicleIDs = JSONParser.decode(jsonData: data, into: VehicleIDs.self)
            self.completionHandler(self.vehicleIDs)

        }
    }
}
