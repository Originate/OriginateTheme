//
//  Components.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import UIKit

struct Components {
    var dictionary: ThemeDefinition
    
    var navigationBar: NavigationBar
    
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
        self.navigationBar = NavigationBar(dictionary: dictionary)
    }
    
    public struct NavigationBar {
        var dictionary: ThemeDefinition
        
        public var backgroundColor: UIColor {
            return UIColor.color("components.", dictionary: dictionary, fallback: UIColor.green)
        }
        
        public var titleFont: UIFont {
            return UIFont.font(keyPath: "fonts.text", dictionary: dictionary, fallback: UIFont.systemFont(ofSize: 16.0))
        }
    }
}
