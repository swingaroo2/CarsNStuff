//
//  URLBuilderTests.swift
//  CarsNStuffTests
//
//  Created by Zach Lockett-Streiff on 7/30/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import XCTest

class URLBuilderTests: XCTestCase {

    let basePath = "https://api.coxauto-interview.com"
    var urlBuilder: URLBuilder?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        urlBuilder = URLBuilder(basePath: basePath)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        urlBuilder = nil
    }
    
    func testDatasetIdURL_validURL() {
        let newURL = urlBuilder?.getDatasetIdURL()
        let expectedURL = URL(string: "https://api.coxauto-interview.com/api/datasetId")!
        let urlsMatch = newURL == expectedURL
        XCTAssertTrue(urlsMatch)
    }
    
    func testGetVehicleIDsURL_validURL() {
        let sampleDatasetID = "DATASETID"
        let newURL = urlBuilder?.getVehicleIDsURL(sampleDatasetID)
        let expectedURL = URL(string: "https://api.coxauto-interview.com/api/\(sampleDatasetID)/vehicles")!
        let urlsMatch = newURL == expectedURL
        XCTAssertTrue(urlsMatch)
    }
    
    func testGetVehicleInfoURL_validURL() {
        let sampleDatasetID = "DATASETID"
        let sampleVehicleID = 616
        let newURL = urlBuilder?.getVehicleInfoURL(sampleDatasetID, sampleVehicleID)
        let expectedURL = URL(string: "https://api.coxauto-interview.com/api/\(sampleDatasetID)/vehicles/\(sampleVehicleID)")!
        let urlsMatch = newURL == expectedURL
        XCTAssertTrue(urlsMatch)
    }
    
    func testGetDealershipInfoURL_validURL() {
        let sampleDatasetID = "DATASETID"
        let sampleDealershipID = Int64(616)
        let newURL = urlBuilder?.getDealershipInfoURL(sampleDatasetID, sampleDealershipID)
        let expectedURL = URL(string: "https://api.coxauto-interview.com/api/\(sampleDatasetID)/dealers/\(sampleDealershipID)")!
        let urlsMatch = newURL == expectedURL
        XCTAssertTrue(urlsMatch)
    }

}
