//
//  JSONParser.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/28/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class JSONParser {
    class func decode<T>(jsonData: Data?, into type: T.Type) -> T? where T: Decodable {
        guard let data = jsonData else {
            
            print("Invalid or nonexistent data")
            return nil
        }
        
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(type, from: data) else {
            
            print("Failed to deconde JSON")
            return nil
        }
        return decoded
    }
}
