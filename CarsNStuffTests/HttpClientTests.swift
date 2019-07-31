//
//  HttpClientTests.swift
//  CarsNStuffTests
//
//  Created by Zach Lockett-Streiff on 7/30/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import XCTest

class HttpClientTests: XCTestCase {

    var httpClient: HttpClient!
    let session = MockURLSession()
    
    override func setUp() {
        httpClient = HttpClient(session)
    }

    func testGetRequestWithURL() {
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url) { (success, response) in
            // Return data
        }
        
        XCTAssert(session.lastURL == url)
    }
    
    func testGetResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url) { (success, response) in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testGetShouldReturnData() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        var actualData: Data?
        httpClient.get(url) { (data, error) in
            actualData = data
        }
        
        XCTAssertNotNil(actualData)
    }
}
