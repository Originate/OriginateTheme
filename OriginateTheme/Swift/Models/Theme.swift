//
//  Theme.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import Foundation

class Theme {

    private var _dictionary: [String: Any]?
    public internal(set) var dictionary: [String: Any]? {
        get {
            return _dictionary
        }
        set {
            _dictionary = newValue
        }
    }
    
    private var _colors: Colors?
    public internal(set) var colors: Colors? {
        get {
            return Colors(dictionary: self.dictionary)
        }
        set {
            _colors = newValue
        }
    }
    
    private var _components: Components?
    public internal(set) var components: Components? {
        get {
            return Components(dictionary: self.dictionary)
        }
        set {
            _components = newValue
        }
    }
    
    
    private var _fonts: Fonts?
    public internal(set) var fonts: Fonts? {
        get {
            return Fonts(dictionary: self.dictionary)
        }
        set {
            _fonts = newValue
        }
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
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                _dictionary = dictionary
            }
            catch let error {
                print("OriginateTheme > Cannot Serialize JSON. Error: \(error)")
            }
        }
        catch let error {
            print("OriginateTheme > Cannot Read JSON from URL. Error: \(error)")
        }
        
    }
    
    public init(dictionary: [String: Any]?) {
        _dictionary = dictionary
    }
}
