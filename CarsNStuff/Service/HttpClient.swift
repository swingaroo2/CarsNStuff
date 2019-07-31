//
//  HttpClient.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/30/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class HttpClient {
    typealias TaskCompletionHandler = (_ data: Data?, _ error: Error?) -> ()
    private let urlSession: URLSessionProtocol

    init(_ urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }

    func get(_ url: URL, _ completion: @escaping TaskCompletionHandler ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            completion(data, error)
        }
        
        task.resume()
    }
}
