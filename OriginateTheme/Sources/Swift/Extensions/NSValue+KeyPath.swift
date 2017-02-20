//
//  NSValue+KeyPath.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import Foundation

extension NSValue {
    class func value(_ keyPath: String, dictionary: [String: Any], fallback: NSValue) -> NSValue {
        return dictionary[keyPath: KeyPath(keyPath)] as? NSValue ?? fallback
    }
}
