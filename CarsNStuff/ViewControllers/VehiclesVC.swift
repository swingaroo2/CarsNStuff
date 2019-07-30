//
//  VehiclesVC.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/29/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import UIKit

class VehiclesVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator!
    var tableManager: VehiclesTableManager!
    var selectedDealerID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.delegate = tableManager
        tableView.dataSource = tableManager
    }
}

extension VehiclesVC: Storyboarded {}
