//
//  ModelTests.swift
//  CarsNStuffTests
//
//  Created by Zach Lockett-Streiff on 7/30/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import XCTest

class ModelTests: XCTestCase {

    // MARK: - VehicleInfo tests
    func testVehicleInfoEquality_equal() {
        let vi1 = VehicleInfo(vehicleId: 1234, year: 2010, make: "Toyota", model: "Prius", dealerId: 7890)
        let vi2 = VehicleInfo(vehicleId: 1234, year: 2010, make: "Toyota", model: "Prius", dealerId: 7890)
        let areEqual = vi1 == vi2
        XCTAssertTrue(areEqual, "VehicleInfo equality evaluation is wrong. Expected equality.")
    }
    
    func testVehicleInfoEquality_notEqual_vehicleId() {
        let vi1 = VehicleInfo(vehicleId: 4321, year: 2010, make: "Toyota", model: "Prius", dealerId: 7890)
        let vi2 = VehicleInfo(vehicleId: 1234, year: 2010, make: "Toyota", model: "Prius", dealerId: 7890)
        let areNotEqual = vi1 == vi2
        XCTAssertFalse(areNotEqual, "VehicleInfo vehicleId equality evaluation is wrong. Expected inequality.")
    }
    
    func testVehicleInfoEquality_notEqual_year() {
        let vi1 = VehicleInfo(vehicleId: 1234, year: 2019, make: "Toyota", model: "Prius", dealerId: 7890)
        let vi2 = VehicleInfo(vehicleId: 1234, year: 2010, make: "Toyota", model: "Prius", dealerId: 7890)
        let areNotEqual = vi1 == vi2
        XCTAssertFalse(areNotEqual, "VehicleInfo year equality evaluation is wrong. Expected inequality.")
    }
    
    func testVehicleInfoEquality_notEqual_make() {
        let vi1 = VehicleInfo(vehicleId: 1234, year: 2010, make: "NotToyota", model: "Prius", dealerId: 7890)
        let vi2 = VehicleInfo(vehicleId: 1234, year: 2010, make: "Toyota", model: "Prius", dealerId: 7890)
        let areNotEqual = vi1 == vi2
        XCTAssertFalse(areNotEqual, "VehicleInfo make equality evaluation is wrong. Expected inequality.")
    }
    
    func testVehicleInfoEquality_notEqual_model() {
        let vi1 = VehicleInfo(vehicleId: 1234, year: 2010, make: "Toyota", model: "Camry", dealerId: 7890)
        let vi2 = VehicleInfo(vehicleId: 1234, year: 2010, make: "Toyota", model: "Prius", dealerId: 7890)
        let areNotEqual = vi1 == vi2
        XCTAssertFalse(areNotEqual, "VehicleInfo model equality evaluation is wrong. Expected inequality.")
    }
    
    func testVehicleInfoEquality_notEqual_dealerId() {
        let vi1 = VehicleInfo(vehicleId: 1234, year: 2010, make: "Toyota", model: "Prius", dealerId: 4444)
        let vi2 = VehicleInfo(vehicleId: 1234, year: 2010, make: "Toyota", model: "Prius", dealerId: 7890)
        let areNotEqual = vi1 == vi2
        XCTAssertFalse(areNotEqual, "VehicleInfo dealerId equality evaluation is wrong. Expected inequality.")
    }

    // MARK: DealershipInfo Tests
    func testDealershipInfoEquality_equal() {
        let di1 = DealershipInfo(dealerId: 1234, name: "Auto von Bismark")
        let di2 = DealershipInfo(dealerId: 1234, name: "Auto von Bismark")
        let areEqual = di1 == di2
        XCTAssertTrue(areEqual, "DealershipInfo equality evaluation is wrong. Expected equality.")
    }
    
    func testDealershipInfoEquality_notEqual_dealerId() {
        let di1 = DealershipInfo(dealerId: 4321, name: "Liam Nissan")
        let di2 = DealershipInfo(dealerId: 1234, name: "Liam Nissan")
        let areNotEqual = di1 == di2
        XCTAssertFalse(areNotEqual, "DealershipInfo dealerId equality evaluation is wrong. Expected inequality.")
    }
    
    func testDealershipInfoEquality_notEqual_name() {
        let di1 = DealershipInfo(dealerId: 1234, name: "The UnCamry Valley")
        let di2 = DealershipInfo(dealerId: 1234, name: "Honda San Miguel")
        let areNotEqual = di1 == di2
        XCTAssertFalse(areNotEqual, "DealershipInfo name equality evaluation is wrong. Expected inequality.")
    }
}
