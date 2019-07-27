//
//  DatasetHttpService.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class DatasetHttpService: NSObject {
    
    func fetchDataset() {
        let urlBuilder = URLBuilder(basePath: HttpConstants.basePath)
        guard let datasetIdURL = urlBuilder.getDatasetIdURL() else {
            // TODO: Graceful error handling
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let datasetTask = urlSession.dataTask(with: datasetIdURL) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // TODO: Graceful error handling
                print("No data obtained from request")
                return
            }
            
            guard let dataset = JSONParser.decode(jsonData: data, into: Dataset.self) else {
                // TODO: Graceful error handling
                print("Failed to parse datasetID from JSON")
                return
            }
        }
        datasetTask.resume()
    }
}


class JSONParser {
    class func decode<T>(jsonData: Data, into type: T.Type) -> T? where T: Decodable {
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(type, from: jsonData) else {
            // TODO: Graceful error handling
            return nil
        }
        return decoded
    }
}
