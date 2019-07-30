//
//  Constants.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

struct ModelConstants {
    static let modelName = "CarsNStuff"
    static let vehicle = "Vehicle"
    static let dealership = "Dealership"
    static let name = "name"
    static let year = "year"
}

struct Predicates {
    static let hasDealerID = "dealerId == %@"
}

struct CellIdentifiers {
    static let generic = "Cell"
    static let dealership = "DealershipCell"
    static let vehicle = "VehicleCell"
}

struct HttpConstants {
    static let basePath = "https://api.coxauto-interview.com"
}

struct TitleConstants {
    static let fetchData = "Fetch Data"
    static let dealerships = "Dealerships"
}
