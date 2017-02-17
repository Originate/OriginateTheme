//
//  Fonts.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import UIKit

struct Fonts {
    var dictionary: ThemeDefinition

    public var body: UIFont {
        return UIFont.font("fonts.text", dictionary: dictionary, fallback: UIFont.systemFont(ofSize: 16.0))
    }
    
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
    }
}
