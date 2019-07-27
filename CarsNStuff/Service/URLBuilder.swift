//
//  URLBuilder.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

struct PathComponents {
    static let dataSetId = "/api/datasetId"
}

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
        let newURL = baseURL?.appendingPathComponent(PathComponents.dataSetId)
        return newURL
    }
}
