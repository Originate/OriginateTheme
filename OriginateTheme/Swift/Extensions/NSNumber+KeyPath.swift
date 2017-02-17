//
//  NSNumber+KeyPath.swift
//  OriginateTheme
//
//  Created by Danny Chhay on 2017-2-16.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import Foundation

extension NSNumber {
    class func number(_ keyPath: String, dictionary: [String: Any], fallback: NSNumber) -> NSNumber {
        return dictionary[keyPath: KeyPath(keyPath)] as? NSNumber ?? fallback
    }
}
