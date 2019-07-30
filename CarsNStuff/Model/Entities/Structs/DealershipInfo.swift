//
//  DealershipInfo.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/29/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

struct DealershipInfo: Codable, Hashable {
    var dealerId: Int64
    var name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func ==(lhs: DealershipInfo, rhs: DealershipInfo) -> Bool {
        return lhs.name == rhs.name && lhs.dealerId == rhs.dealerId
    }
}
