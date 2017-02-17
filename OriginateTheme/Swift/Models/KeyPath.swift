//
//  KeyPath.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import Foundation

struct KeyPath {
    var segments: [String]
    
    var isEmpty: Bool { return segments.isEmpty }
    var path: String {
        return segments.joined(separator: ".")
    }
    
    func headAndTail() -> (head: String, tail: KeyPath)? {
        guard !isEmpty else { return nil }
        var tail = segments
        let head = tail.removeFirst()
        return (head, KeyPath(segments: tail))
    }
}

extension KeyPath {
    init(_ string: String) {
        segments = string.components(separatedBy: ".")
    }
}

extension KeyPath: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(value)
    }
    
    init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
    
    init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}
