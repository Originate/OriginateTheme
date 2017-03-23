//
//  UIFont+KeyPath.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import UIKit

extension UIFont {
    class func font(_ keyPath: String, dictionary: [String: Any], fallback: UIFont) -> UIFont {
        let size = Float(dictionary[keyPath: KeyPath("\(keyPath).size")] as? String ?? "\(fallback.pointSize)") ?? Float(UIFont.systemFontSize)
        let name = dictionary[keyPath: KeyPath(keyPath)] as? String ?? fallback.fontName

        return UIFont(name: name, size: CGFloat(size)) ?? fallback
    }
}
