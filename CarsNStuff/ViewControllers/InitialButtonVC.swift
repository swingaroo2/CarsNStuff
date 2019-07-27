//
//  InitialButtonVC.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/27/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import UIKit

class InitialButtonVC: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    @IBAction func fetchButtonTapped() {
        coordinator?.showDealerships()
    }
    
}

extension InitialButtonVC: Storyboarded {}
