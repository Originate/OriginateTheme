//
//  NSDictionary+KeyPath.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import Foundation

extension Dictionary where Key: StringInitializable {
    subscript(keyPath keyPath: KeyPath) -> Any? {
        get {
            switch keyPath.headAndTail() {
            case nil:
                return nil
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                let key = Key(string: head)
                return self[key]
            case let (head, remainingKeyPath)?:
                let key = Key(string: head)
                switch self[key] {
                case let nestedDict as [Key: Any]:
                    return nestedDict[keyPath: remainingKeyPath]
                default:
                    return nil
                }
            }
        }
        set {
            switch keyPath.headAndTail() {
            case nil:
                return
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                let key = Key(string: head)
                self[key] = newValue as? Value
            case let (head, remainingKeyPath)?:
                let key = Key(string: head)
                let value = self[key]
                switch value {
                case var nestedDict as [Key: Any]:
                    nestedDict[keyPath: remainingKeyPath] = newValue
                    self[key] = nestedDict as? Value
                default:
                    return
                }
            }
        }
    }
}

