//
//  UIButton+Extensions.swift
//  CarsNStuff
//
//  Created by Zach Lockett-Streiff on 7/30/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func enable(enabledColor: UIColor) {
        isEnabled = true
        backgroundColor = enabledColor
        setTitleColor(.darkText, for: .normal)
        setTitleColor(.darkText, for: .selected)
    }
    
    func disable(disabledColor: UIColor? = UIColor.lightGray) {
        isEnabled = false
        backgroundColor = disabledColor
        setTitleColor(.lightText, for: .normal)
        setTitleColor(.lightText, for: .selected)
    }
}
