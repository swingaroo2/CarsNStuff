//
//  DatasetOperation.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/28/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class DatasetOperation: Operation {
    typealias DatasetHandler = (Dataset?) -> ()
    
    private let urlSession: URLSession
    private let completionHandler: DatasetHandler
    var dataset: Dataset?
    
    init(_ urlSession: URLSession, completionHandler: @escaping DatasetHandler) {
        self.urlSession = urlSession
        self.completionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        if isCancelled {
            print("\(#function): DatasetOperation is cancelled")
            return
        }
        
        let urlBuilder = URLBuilder(basePath: HttpConstants.basePath)
        guard let url = urlBuilder.getDatasetIdURL() else {
            print("Failed to get URL for dataset ID task")
            return
        }
        
        let datasetTask = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            self.dataset = JSONParser.decode(jsonData: data, into: Dataset.self)
            self.completionHandler(self.dataset)
        }
        
        datasetTask.resume()
    }
}
