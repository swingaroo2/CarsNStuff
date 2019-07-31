//
//  JSONParserTests.swift
//  CarsNStuffTests
//
//  Created by Zach Lockett-Streiff on 7/31/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import XCTest

class JSONParserTests: XCTestCase {

    func testJSONParserFailsGracefully_nilInput() {
        let result = JSONParser.decode(jsonData: nil, into: Dataset.self)
        let isResultNil = result == nil
        XCTAssertTrue(isResultNil, "JSONParser did not fail gracefully and return nil for nil input")
    }
    
    func testJSONParser_validDatset() {
        let dataset = Dataset(datasetId: "DATASET")
        let encoded = try! JSONEncoder().encode(dataset)
        let decoded = JSONParser.decode(jsonData: encoded, into: Dataset.self)
        let isValid = decoded != nil
        XCTAssertTrue(isValid, "JSONParser did not successfully encode Dataset from JSON data")
    }
    
    func testJSONParser_validVehicleIDs() {
        let vehicleIDs = VehicleIDs(vehicleIds: [0,1,2])
        let encoded = try! JSONEncoder().encode(vehicleIDs)
        let decoded = JSONParser.decode(jsonData: encoded, into: VehicleIDs.self)
        let isValid = decoded != nil
        XCTAssertTrue(isValid, "JSONParser did not successfully encode VehicleIDs from JSON data")
    }
    
    func testJSONParser_validVehicleInfo() {
        let vehicleInfo = VehicleInfo(vehicleId: 1234, year: 2010, make: "Toyota", model: "Prius", dealerId: 1234)
        let encoded = try! JSONEncoder().encode(vehicleInfo)
        let decoded = JSONParser.decode(jsonData: encoded, into: VehicleInfo.self)
        let isValid = decoded != nil
        XCTAssertTrue(isValid, "JSONParser did not successfully encode VehicleInfo from JSON data")
    }
    
    func testJSONParser_validDealershipInfo() {
        let dealershipInfo = DealershipInfo(dealerId: 1234, name: "Virtual Wheel-ity")
        let encoded = try! JSONEncoder().encode(dealershipInfo)
        let decoded = JSONParser.decode(jsonData: encoded, into: DealershipInfo.self)
        let isValid = decoded != nil
        XCTAssertTrue(isValid, "JSONParser did not successfully encode DealershipInfo from JSON data")
    }

}
