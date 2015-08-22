//
//  UIView+IB.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 29/06/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else
            {
                return nil
            }
            return UIColor(CGColor: borderColor)
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }
}