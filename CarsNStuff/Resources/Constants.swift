//
//  Constants.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

// MARK: - String structs
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
    static let fetching = "Fetching..."
    static let dealerships = "Dealerships"
    static let dismiss = "Dismiss"
}

struct ButtonTitles {
    static let fetchButtonNormal = "Fetch Dealership and Vehicle Data"
    static let fetchButtonSelected = "Fetching..."
}

// MARK: - Color structs
struct Colors {
    static let fetchButton = UIColor(red: 74/255.0, green: 171/255.0, blue: 247/255.0, alpha: 1)
}

// MARK: - Enums

enum ButtonState {
    case enabled
    case disabled
}


