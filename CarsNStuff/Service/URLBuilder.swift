//
//  URLBuilder.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class URLBuilder {
    var baseURL: URL?
    
    init(basePath: String) {
        self.baseURL = URL(string: basePath)
    }
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}

extension URLBuilder {
    func getDatasetIdURL() -> URL? {
        let path = "/api/datasetId"
        let newURL = baseURL?.appendingPathComponent(path)
        return newURL
    }
    
    func getVehicleIDsURL(_ dataset: Dataset) -> URL? {
        let path = String(format: "/api/%@/vehicles", dataset.datasetId)
        let newURL = baseURL?.appendingPathComponent(path)
        return newURL
    }
}
