//
//  UIView+Extension.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/30/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fadeOut(for fadeInView: UIView, duration: TimeInterval = 0.2) {
        UIView.animate(withDuration: duration) { [unowned self] in
            self.alpha = 0.0
            fadeInView.alpha = 1.0
        }
    }
}
