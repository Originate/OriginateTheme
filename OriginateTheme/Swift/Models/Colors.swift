//
//  Colors.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import UIKit

public struct Colors {
    var dictionary: ThemeDefinition
    
    public var text: UIColor {
        return UIColor.color("colors.red", dictionary: dictionary, fallback: UIColor.green)
    }
    
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
    }
}
