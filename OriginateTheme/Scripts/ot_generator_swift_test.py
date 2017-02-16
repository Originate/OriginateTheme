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

navigationBarStruct = """public struct navigationBar {
    public var backgroundColor: UIColor {
        return UIColor.color("colors.red", dictionary: dictionary, fallback: UIColor.green)
    }
    public var font: UIFont {
        return UIFont.font(keyPath: "fonts.text", dictionary: dictionary, fallback: UIFont.systemFont(ofSize: 16.0))
    }
}"""
navigationBarBody = """    public var backgroundColor: UIColor {
        return UIColor.color("colors.red", dictionary: dictionary, fallback: UIColor.green)
    }
    public var font: UIFont {
        return UIFont.font(keyPath: "fonts.text", dictionary: dictionary, fallback: UIFont.systemFont(ofSize: 16.0))
    }"""

varName = "backgroundColor"
varType = "UIColor"

exColorStruct = """public struct Colors {
    var dictionary: ThemeDefinition
    \n\
    public var red: UIColor {
        return UIColor.color("colors.red", dictionary: dictionary, fallback: UIColor.green)
    }
    \n\
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
    }
}"""

exFontStruct = """public struct Fonts {
    var dictionary: ThemeDefinition
    \n\
    public var text: UIFont {
        return UIFont.font("fonts.text", dictionary: dictionary, fallback: UIFont(name: "HelveticaNeue", size: 15))
    }
    \n\
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
    }
}"""

exInitItem = """public init(dictionary: ThemeDefinition = [:]) {
    self.dictionary = dictionary
    self.navigationBar = NavigationBar(dictionary: dictionary)
}"""

exComponentsStruct = """public struct Components {
    var dictionary: ThemeDefinition
    \n\
    var navigationBar: NavigationBar
    \n\
    public init(dictionary: ThemeDefinition = [:]) {
        self.dictionary = dictionary
        self.navigationBar = NavigationBar(dictionary: dictionary)
    }
    \n\
    public struct NavigationBar {
        var dictionary: ThemeDefinition
        \n\
        public var red: UIColor {
            return UIColor.color("colors.red", dictionary: dictionary, fallback: UIColor.green)
        }
        \n\
        public var text: UIFont {
            return UIFont.font("fonts.text", dictionary: dictionary, fallback: UIFont(name: "HelveticaNeue", size: 15))
        }
        \n\
        public init(dictionary: ThemeDefinition = [:]) {
            self.dictionary = dictionary
        }
    }
}"""

otThemeObjectDictionaryVar = varWith('dictionary', 'ThemeDefinition')

def failureMessageWith(expected, actual):
    return '\nexpected: ' + expected + '!=\n' + 'actual: ' + actual

class VarTestCase(unittest.TestCase):
    def runTest(self):
        expected = "var backgroundColor: UIColor"
        data = varWith(varName, varType)
        self.assertEqual(expected, data)

class OriginateThemePropertyComputationTestCase(unittest.TestCase):
    def runTest(self):
        expected = "UIColor.color(\"colors.red\", dictionary: dictionary, fallback: UIColor.green)"
        data = otComputationWith("UIColor.color", "colors.red", "dictionary", "UIColor.green")
        self.assertEqual(expected, data)

class StaticPublicComputedPropertyTestCase(unittest.TestCase):
    def runTest(self):
        expected = """public var backgroundColor: UIColor {
    return UIColor.color("colors.red", dictionary: dictionary, fallback: UIColor.green)
}"""
        computation  =  otComputationWith("UIColor.color", "colors.red", "dictionary", "UIColor.green")
        data = computedPropertyWith(varName, varType, computation)
        self.assertEqual(expected, data)

class StructTestCase(unittest.TestCase):
    def runTest(self):
        expected = navigationBarStruct
        structName = "navigationBar"
        body = navigationBarBody
        data = structWithBody(structName, body)

        self.assertEqual(expected, data, msg = failureMessageWith(expected, data))

class ColorPropertyTestCase(unittest.TestCase):
    def runTest(self):
        expected = """public var primary: UIColor {
    return UIColor.color("colors.primary", dictionary: dictionary, fallback: UIColor.green)
}"""
        data = createColorProperty(Color('primary', 'UIColor.green'))
        self.assertEqual(expected, data, msg = failureMessageWith(expected, data))

class FontPropertyTestCase(unittest.TestCase):
    def runTest(self):
        expected = """public var text: UIFont {
    return UIFont.font("fonts.text", dictionary: dictionary, fallback: UIFont(name: "HelveticaNeue", size: 15))
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
        expected = exColorStruct
        implementationItems = [otThemeObjectDictionaryVar, createColorProperty(Color('red', 'UIColor.green')), otThemeObjectInitWithItems()]
        data = structWithItems("Colors", implementationItems)
        self.assertEqual(expected, data, msg=failureMessageWith(expected,data))

class CreateFontsStructTestCase(unittest.TestCase):
    def runTest(self):
        expected = exFontStruct
        implementationItems = [otThemeObjectDictionaryVar, createFontProperty(Font('text', 'HelveticaNeue', 15)), otThemeObjectInitWithItems()]
        data = structWithItems("Fonts", implementationItems)
        self.assertEqual(expected, data, msg=failureMessageWith(expected,data))

class ThemeObjectInitExtraTestCase(unittest.TestCase):
    def runTest(self):
        expected = exInitItem
        items = [otThemeObjectStandardInitLine, "self.navigationBar = NavigationBar(dictionary: dictionary)"]
        data = otThemeObjectInitWithItems(items)
        self.assertEqual(expected, data, msg=failureMessageWith(expected,data))

class CreateComponentsTestCase(unittest.TestCase):
    def runTest(self):
        expected = exComponentsStruct
        navBarName = 'NavigationBar'
        componentVars = [varWith('dictionary', 'ThemeDefinition'), varWith('navigationBar', navBarName)]
        init = otThemeObjectInitWithItems([otThemeObjectStandardInitLine, "self.navigationBar = NavigationBar(dictionary: dictionary)"])

        navigationBarImplementationItems = [otThemeObjectDictionaryVar, createColorProperty(Color('red', 'UIColor.green')), createFontProperty(Font('text', 'HelveticaNeue', 15)), otThemeObjectInitWithItems()]
        navigationBarStruct = structWithItems(navBarName, navigationBarImplementationItems)

        items = []
        items.extend(componentVars)
        items.append(init)
        items.append(navigationBarStruct)
        data = structWithItems('Components',items)
        self.assertEqual(expected, data, msg=failureMessageWith(expected,data))
