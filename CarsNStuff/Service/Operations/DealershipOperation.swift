//
//  DealershipOperation.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/29/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class DealershipInfoOperation: Operation {
    typealias DealershipInfoHandler = (DealershipInfo?) -> ()
    
    private let urlSession: URLSession
    private let completionHandler: DealershipInfoHandler
    var coreDataManager: CoreDataManager!
    var dealershipInfo: DealershipInfo?
    var datasetID: String?
    var dealershipID: Int64?
    
    init(_ urlSession: URLSession, completionHandler: @escaping DealershipInfoHandler) {
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
        guard let datasetID = datasetID, let dealershipID = dealershipID else { return }
        guard let url = urlBuilder.getDealershipInfoURL(datasetID, dealershipID) else { return }
        
        let dealershipInfoTask = urlSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            self.dealershipInfo = JSONParser.decode(jsonData: data, into: DealershipInfo.self)
            
            guard let dealershipInfo = self.dealershipInfo else { return }
            self.completionHandler(dealershipInfo)
        }
        
        dealershipInfoTask.resume()
    }
}
