//
//  Components.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import UIKit

public struct Components {
    var dictionary: ThemeDefinition
    
    lazy var navigationBar: NavigationBar = {
        return NavigationBar(dictionary: self.dictionary)
    }()
    
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
    }
}

public struct NavigationBar {
    var dictionary: ThemeDefinition
    
    public var description: UIFont {
        return UIFont.font("fonts.description", dictionary: dictionary, fallback: UIFont(name: "HelveticaNeue-Light", size: 12.0)!)
    }
    
    public var text: UIFont {
        return UIFont.font("fonts.text", dictionary: dictionary, fallback: UIFont(name: "HelveticaNeue-Light", size: 14.0)!)
    }
    
    public var background: UIColor {
        return UIColor.color("colors.background", dictionary: dictionary, fallback: UIColor.color("84E0FAFF"))
    }
    
    public var tint: UIColor {
        return UIColor.color("colors.tint", dictionary: dictionary, fallback: UIColor.color("000000FF"))
    }
    
    public var isTranslucent: Bool {
        return NSNumber.number("bool.isTranslucent", dictionary: dictionary, fallback: NSNumber(value: true)).boolValue
    }
    
    public var iconOffset: CGPoint {
        return NSValue.value("point.iconOffset", dictionary: dictionary, fallback: NSValue(cgPoint: CGPoint(x: 15, y: 20))).cgPointValue
    }
    
    public var textInsets: UIEdgeInsets {
        return NSValue.value("insets.textInsets", dictionary: dictionary, fallback: NSValue(uiEdgeInsets: UIEdgeInsets(top: 15, left: 20, bottom: 10, right: 5))).uiEdgeInsetsValue
    }
    
    public var elementFrame: CGRect {
        return NSValue.value("rects.elementFrame", dictionary: dictionary, fallback: NSValue(cgRect: CGRect(x: 15, y: 20, width: 10, height: 5))).cgRectValue
    }
    
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
    }
}
