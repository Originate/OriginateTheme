#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
    ot_generator_swift_test.py
    Collection of tests for the ot_generator_swift_test.py script.
"""

import os
import unittest
import json

from ot_generator_swift import *
from ot_generator import *

varName = "backgroundColor"
varType = "UIColor"

exComponentsStruct = """public struct Components {
    var dictionary: ThemeDefinition
    \n\
    lazy var navigationBar: NavigationBar = {
        return NavigationBar(dictionary: self.dictionary)
    }()
    \n\
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
    }
}

public struct NavigationBar {
    var dictionary: ThemeDefinition
    \n\
    public var description: UIFont {
        return UIFont.font("fonts.description", dictionary: dictionary, fallback: UIFont(name: "HelveticaNeue-Light", size: 12.0)!)
    }
    \n\
    public var text: UIFont {
        return UIFont.font("fonts.text", dictionary: dictionary, fallback: UIFont(name: "HelveticaNeue-Light", size: 14.0)!)
    }
    \n\
    public var background: UIColor {
        return UIColor.color("colors.background", dictionary: dictionary, fallback: UIColor.color("84E0FAFF"))
    }
    \n\
    public var tint: UIColor {
        return UIColor.color("colors.tint", dictionary: dictionary, fallback: UIColor.color("000000FF"))
    }
    \n\
    public var isTranslucent: Bool {
        return NSNumber.number("bool.isTranslucent", dictionary: dictionary, fallback: NSNumber(value: true)).boolValue
    }
    \n\
    public var iconOffset: CGPoint {
        return NSValue.value("point.iconOffset", dictionary: dictionary, fallback: NSValue(cgPoint: CGPoint(x: 15, y: 20))).cgPointValue
    }
    \n\
    public var textInsets: UIEdgeInsets {
        return NSValue.value("insets.textInsets", dictionary: dictionary, fallback: NSValue(uiEdgeInsets: UIEdgeInsets(top: 15, left: 20, bottom: 10, right: 5))).uiEdgeInsetsValue
    }
    \n\
    public var elementFrame: CGRect {
        return NSValue.value("rects.elementFrame", dictionary: dictionary, fallback: NSValue(cgRect: CGRect(x: 15, y: 20, width: 10, height: 5))).cgRectValue
    }
    \n\
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
    }
}"""



def failureMessageWith(expected, actual):
    return '\nexpected: ' + expected + '!=\n' + 'actual: ' + actual

class VarTestCase(unittest.TestCase):
    def runTest(self):
        expected = "var backgroundColor: UIColor"
        data = varWith(varName, varType)
        self.assertEqual(expected, data)

class OriginateThemePropertyComputationTestCase(unittest.TestCase):
    def runTest(self):
        expected = "UIColor.color(\"colors.red\", dictionary: dictionary, fallback: UIColor.green!)"
        data = otComputationWith("UIColor.color", "colors.red", "dictionary", "UIColor.green!")
        self.assertEqual(expected, data)

class StaticPublicComputedPropertyTestCase(unittest.TestCase):
    def runTest(self):
        expected = """public var backgroundColor: UIColor {
    return UIColor.color("colors.red", dictionary: dictionary, fallback: UIColor.color("FF0000")!)
}"""
        computation  =  otComputationWith("UIColor.color", "colors.red", "dictionary", "UIColor.color(\"FF0000\")!")
        data = computedPropertyWith(varName, varType, computation)
        self.assertEqual(expected, data)

class StructTestCase(unittest.TestCase):
    def runTest(self):
        expected = """\
public struct NavigationBar {
    body
}"""
        structName = "NavigationBar"
        body = "    body"
        data = structWithBody(structName, body)

        self.assertEqual(expected, data, msg = failureMessageWith(expected, data))

class ColorPropertyTestCase(unittest.TestCase):
    def runTest(self):
        expected = """public var primary: UIColor {
    return UIColor.color("colors.primary", dictionary: dictionary, fallback: UIColor.color("FF0000"))
}"""
        data = createColorProperty(Color('primary', 'FF0000'))
        self.assertEqual(expected, data, msg = failureMessageWith(expected, data))

class FontPropertyTestCase(unittest.TestCase):
    def runTest(self):
        expected = """public var text: UIFont {
    return UIFont.font("fonts.text", dictionary: dictionary, fallback: UIFont(name: "HelveticaNeue", size: 15)!)
}"""
        data = createFontProperty(Font('text', 'HelveticaNeue', 15))
        self.assertEqual(expected, data, msg = failureMessageWith(expected, data))

class IndentTestCase(unittest.TestCase):
    def runTest(self):
        beforeIndent = """1
1"""
        expected = """    1
    1"""
        data = indent(beforeIndent, 4)
        self.assertEqual(expected, data, msg=failureMessageWith(expected, data))

class CreateColorsStructTestCase(unittest.TestCase):
    def runTest(self):
        expected = """\
public struct Colors {
    var dictionary: ThemeDefinition
    \n\
    public var red: UIColor {
        return UIColor.color("colors.red", dictionary: dictionary, fallback: UIColor.color("FF0000"))
    }
    \n\
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
    }
}"""
        color = Color('red', 'FF0000')
        data = createColorStruct(color)
        self.assertEqual(expected, data, msg=failureMessageWith(expected,data))

class CreateFontsStructTestCase(unittest.TestCase):
    def runTest(self):
        expected = """\
public struct Fonts {
    var dictionary: ThemeDefinition
    \n\
    public var text: UIFont {
        return UIFont.font("fonts.text", dictionary: dictionary, fallback: UIFont(name: "HelveticaNeue", size: 15)!)
    }
    \n\
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
    }
}"""
        font = Font('text', 'HelveticaNeue', 15)
        data = createFontStruct(font)
        self.assertEqual(expected, data, msg=failureMessageWith(expected,data))

class ThemeObjectInitExtraTestCase(unittest.TestCase):
    def runTest(self):
        expected = """\
public init(dictionary: ThemeDefinition = [:]) {
    self.dictionary = dictionary
    self.navigationBar = NavigationBar(dictionary: dictionary)
}"""
        items = [otThemeObjectStandardInitLine, "self.navigationBar = NavigationBar(dictionary: dictionary)"]
        data = otThemeObjectInitWithItems(items)
        self.assertEqual(expected, data, msg=failureMessageWith(expected,data))

class CreateComponentsTestCase(unittest.TestCase):
    def runTest(self):
        expected = exComponentsStruct
        jsonData = json.loads('{ "navigationBar" : { "colors" : { "background" : "84E0FA", "tint" : "000000" }, "fonts" : { "text" : { "name" : "HelveticaNeue-Light", "size" : 14.0 }, "description" : { "name" : "HelveticaNeue-Light", "size" : 12.0 } }, "isTranslucent" : true, "iconOffset":  { "x": 15, "y": 20 }, "textInsets": { "top": 15, "left": 20, "bottom": 10, "right": 5 }, "elementFrame": { "x": 15, "y": 20, "width": 10, "height": 5 } } }')
        components = parseComponents(jsonData)
        data = createAggregatedComponents('Components',components)
        self.assertEqual(expected, data, msg=failureMessageWith(expected,data))
