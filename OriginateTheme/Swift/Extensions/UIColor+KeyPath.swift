//
//  UIColor+KeyPath.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import UIKit

extension UIColor {
    class func color(_ keyPath: String, dictionary: [String: Any], fallback: UIColor) -> UIColor {
        if let colorValue = dictionary[keyPath: KeyPath(keyPath)] as? String {
            return UIColor.color(colorValue)
        }
        return fallback
    }    
}
