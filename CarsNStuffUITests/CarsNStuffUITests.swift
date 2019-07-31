//
//  CarsNStuffUITests.swift
//  CarsNStuffUITests
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import XCTest

class CarsNStuffUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
    }

    func testAppFlow() {
        app.buttons[ButtonTitles.fetchButtonNormal].tap()
        let progressViewText = app.staticTexts[ButtonTitles.fetchButtonSelected]
        let dealershipsTable = app.tables.firstMatch
        let elementExists = NSPredicate(format: "exists == 1")
        
        expectation(for: elementExists, evaluatedWith: progressViewText)
        expectation(for: elementExists, evaluatedWith: dealershipsTable)
        waitForExpectations(timeout: 30)
        
        let dealershipTableViewCell = dealershipsTable.cells.firstMatch
        XCTAssertTrue(dealershipTableViewCell.exists, "Dealership table view is not populated")
        
        for index in 0..<dealershipsTable.cells.count {
            dealershipsTable.cells.element(boundBy: index).tap()
            let firstVehicle = app.tables.staticTexts.element(boundBy: 0)
            XCTAssertTrue(firstVehicle.exists, "Vehicles table view is not populated.")
            app.navigationBars.buttons[TitleConstants.dealerships].tap()
        }
        
        let dismissButton = app.navigationBars.buttons[TitleConstants.dismiss]
        if dismissButton.exists {
            dismissButton.tap()
        } else {
            app.navigationBars.buttons[TitleConstants.fetchData].tap()
            app.navigationBars.buttons[ButtonTitles.navButtonStoredData].tap()
        }
        
    }

}
