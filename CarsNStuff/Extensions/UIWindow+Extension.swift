//
//  UIWindow+Extension.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 8/1/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    class func createNewWindow(with rootNavController: UINavigationController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootNavController
        window.makeKeyAndVisible()
        return window
    }
}
