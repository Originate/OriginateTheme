//
//  Theme.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import Foundation

public typealias ThemeDefinition = [String: Any]

public struct Theme {

    private var _dictionary: ThemeDefinition = [:]
    public internal(set) var dictionary: ThemeDefinition {
        get {
            return _dictionary
        }
        set {
            _dictionary = newValue
        }
    }
    
    public var colors: Colors {
        return Colors(dictionary: self.dictionary)
    }
    
    public var components: Components {
        return Components(dictionary: self.dictionary)
    }
    
    
    public var fonts: Fonts {
        return Fonts(dictionary: self.dictionary)
    }
    
    public init(URL: URL) {
        do {
            let json: String = try String(contentsOf: URL, encoding: .utf8)
            let encodedData = json.data(using: .utf8)
            
            guard let data = encodedData else {
                print("OriginateTheme > Attempting to load non-existent theme. Falling back to default values.")
                return
            }
            
            do {
                let serializedObject = try JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = serializedObject as? ThemeDefinition {
                    _dictionary = dictionary
                }
            }
            catch let error {
                print("OriginateTheme > Cannot Serialize JSON. Error: \(error)")
            }
        }
        catch let error {
            print("OriginateTheme > Cannot Read JSON from URL. Error: \(error)")
        }
        
    }
    
    public init(dictionary: ThemeDefinition = [:]) {
        _dictionary = dictionary
    }
}
