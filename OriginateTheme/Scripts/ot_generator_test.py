#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
    otgenerator.py
    Collection of tests for the ot_generator.py script.
"""

import os
import unittest

from ot_generator import *

class ParseFontsTestCase(unittest.TestCase):
    def runTest(self):
        data = json.loads('{ "default" : { "name" : "HelveticaNeue","size" : 15.0 }, "defaultBold" : { "name" : "HelveticaNeue-Bold", "size" : 15.0 }, "defaultLight" : { "name" : "HelveticaNeue-Light", "size" : 15.0 } }')
        output = parseFonts(data)

        self.assertTrue(len(output))
        self.assertEqual(output[0].key, 'default')
        self.assertEqual(output[0].name, 'HelveticaNeue')
        self.assertEqual(output[0].size, 15.0)
        self.assertEqual(output[1].key, 'defaultBold')
        self.assertEqual(output[1].name, 'HelveticaNeue-Bold')
        self.assertEqual(output[1].size, 15.0)
        self.assertEqual(output[2].key, 'defaultLight')
        self.assertEqual(output[2].name, 'HelveticaNeue-Light')
        self.assertEqual(output[2].size, 15.0)

class ParseColorsTestCase(unittest.TestCase):
    def runTest(self):
        data = json.loads('{ "primary" : "EFEFEF", "secondary" : "636363" }')
        output = parseColors(data)

        self.assertTrue(len(output))
        self.assertEqual(output[0].key, 'primary')
        self.assertEqual(output[0].code, 'EFEFEFFF')
        self.assertEqual(output[1].key, 'secondary')
        self.assertEqual(output[1].code, '636363FF')

class ParseBoolsTestCase(unittest.TestCase):
    def runTest(self):
        data = json.loads('{ "isTranslucent" : true, "hasShadow" : false }')
        output = parseBools(data)

        self.assertTrue(len(output))
        self.assertEqual(output[0].key, 'isTranslucent')
        self.assertEqual(output[0].boolValue, True)
        self.assertEqual(output[1].key, 'hasShadow')
        self.assertEqual(output[1].boolValue, False)

class ParseComponents(unittest.TestCase):
    def runTest(self):
        data = json.loads('{ "navigationBar" : { "colors" : { "background" : "84E0FA", "tint" : "000000" }, "fonts" : { "text" : { "name" : "HelveticaNeue-Light", "size" : 14.0 }, "description" : { "name" : "HelveticaNeue-Light", "size" : 12.0 } }, "isTranslucent" : true} }')
        output = parseComponents(data)

        self.assertTrue(len(output))
        self.assertEqual(output[0].key, 'navigationBar')
        self.assertTrue(output[0].colors)
        self.assertTrue(output[0].fonts)
        self.assertTrue(output[0].bools)
        self.assertEqual(output[0].colors[0].key, 'background')
        self.assertEqual(output[0].colors[0].code, '84E0FAFF')
        self.assertEqual(output[0].colors[1].key, 'tint')
        self.assertEqual(output[0].colors[1].code, '000000FF')
        self.assertEqual(output[0].fonts[0].key, 'description')
        self.assertEqual(output[0].fonts[0].name, 'HelveticaNeue-Light')
        self.assertEqual(output[0].fonts[0].size, 12.0)
        self.assertEqual(output[0].fonts[1].key, 'text')
        self.assertEqual(output[0].fonts[1].name, 'HelveticaNeue-Light')
        self.assertEqual(output[0].fonts[1].size, 14.0)
        self.assertEqual(output[0].bools[0].key, 'isTranslucent')
        self.assertEqual(output[0].bools[0].boolValue, True)

class UpcaseFirstLetterTestCase(unittest.TestCase):
    def runTest(self):
        output = upcaseFirstLetter('thisIsAString')
        self.assertEqual(output, 'ThisIsAString')

class CreatePropertyTestCase(unittest.TestCase):
    def runTest(self):
        output = createProperty('strong', 'readonly', 'UIColor', 'greenColor')
        self.assertEqual(output, '@property (nonatomic, strong, readonly) UIColor *greenColor;')

class CreatePropertyKeyPathKeyTestCase(unittest.TestCase):
    def runTest(self):
        output = createPropertyKeyPathKey('Colors', 'title')
        self.assertEqual(output, 'OTColorsTitleKeyPathKey')

class CreatePropertyKeyPathKeyDefinitionTestCase(unittest.TestCase):
    def runTest(self):
        output = createPropertyKeyPathKeyDefinition('OTColorsTitleKeyPathKey', 'colors.title')
        self.assertEqual(output, 'NSString * const OTColorsTitleKeyPathKey = @"colors.title";')

class GenerateUITypeClassColorContentTestCase(unittest.TestCase):
    def runTest(self):
        data = json.loads('{ "fonts" : { "default" : { "name" : "HelveticaNeue", "size" : 22.0 }, "defaultBold" : { "name" : "HelveticaNeue-Bold", "size" : 14.0 }, "defaultLight" : { "name" : "HelveticaNeue-Light", "size" : 16.0 }, "defaultItalic" : { "name" : "HelveticaNeue-Thin", "size" : 14.0 } }, "colors" : { "primary" : "70CFFF" , "secondary" : "FCD92B", "title" : "000000", "caption" : "545454", "success" : "95BE22", "warning" : "FFA500", "error" : "BD2C00" }, "components" : { "navigationBar" : { "colors" : { "background" : "84E0FA", "tint" : "979797" }, "fonts" : { "text" : { "name" : "HelveticaNeue-Light", "size" : 14.0 }, "description" : {"name" : "HelveticaNeue-Light", "size" : 12.0 } } }, "tabBar" : { "colors" : { "background" : "FFFFFF", "tint" : "FF9600" }, "fonts" : { "text" : { "name" : "HelveticaNeue-Light", "size" : 14.0 } } } } }')

        # Prepare the UI type class color content generation test cases.
        (fonts, colors, components) = ([], [], [])
        (fonts, colors, components) = (parseFonts(data['fonts']), parseColors(data['colors']), parseComponents(data['components']))
        testDirectory = os.path.dirname(__file__)

        # Test the color header content generation.
        output = generateUITypeClassHeaderFileContent('OTColors', sorted(colors, key = lambda x: x.key), 'color', createColorGetter)
        filePath = os.path.join(testDirectory, 'Validation/OTColors.h.test')
        with open(filePath) as file:
            self.assertEqual(output, file.read())

        # Test the color main content generation.
        output = generateUITypeClassMainFileContent('OTColors', sorted(colors, key = lambda x: x.key), 'color', createColorGetter)
        filePath = os.path.join(testDirectory, 'Validation/OTColors.m.test')
        with open(filePath) as file:
            self.assertEqual(output, file.read())

class GenerateUITypeClassFontContentTestCase(unittest.TestCase):
    def runTest(self):
        data = json.loads('{ "fonts" : { "default" : { "name" : "HelveticaNeue", "size" : 22.0 }, "defaultBold" : { "name" : "HelveticaNeue-Bold", "size" : 14.0 }, "defaultLight" : { "name" : "HelveticaNeue-Light", "size" : 16.0 }, "defaultItalic" : { "name" : "HelveticaNeue-Thin", "size" : 14.0 } }, "colors" : { "primary" : "70CFFF" , "secondary" : "FCD92B", "title" : "000000", "caption" : "545454", "success" : "95BE22", "warning" : "FFA500", "error" : "BD2C00" }, "components" : { "navigationBar" : { "colors" : { "background" : "84E0FA", "tint" : "979797" }, "fonts" : { "text" : { "name" : "HelveticaNeue-Light", "size" : 14.0 }, "description" : {"name" : "HelveticaNeue-Light", "size" : 12.0 } } }, "tabBar" : { "colors" : { "background" : "FFFFFF", "tint" : "FF9600" }, "fonts" : { "text" : { "name" : "HelveticaNeue-Light", "size" : 14.0 } } } } }')

        # Prepare the UI type class font content generation test cases.
        (fonts, colors, components) = ([], [], [])
        (fonts, colors, components) = (parseFonts(data['fonts']), parseColors(data['colors']), parseComponents(data['components']))
        testDirectory = os.path.dirname(__file__)

        # Test the font header content generation.
        output = generateUITypeClassHeaderFileContent('OTFonts', sorted(fonts, key = lambda x: x.key), 'font', createFontGetter)
        filePath = os.path.join(testDirectory, 'Validation/OTFonts.h.test')
        with open(filePath) as file:
            self.assertEqual(output, file.read())

        # Test the font main content generation.
        output = generateUITypeClassMainFileContent('OTFonts', sorted(fonts, key = lambda x: x.key), 'font', createFontGetter)
        filePath = os.path.join(testDirectory, 'Validation/OTFonts.m.test')
        with open(filePath) as file:
            self.assertEqual(output, file.read())

class GenerateComponentsContentTestCase(unittest.TestCase):
    def runTest(self):
        data = json.loads('{ "fonts" : { "default" : { "name" : "HelveticaNeue", "size" : 22.0 }, "defaultBold" : { "name" : "HelveticaNeue-Bold", "size" : 14.0 }, "defaultLight" : { "name" : "HelveticaNeue-Light", "size" : 16.0 }, "defaultItalic" : { "name" : "HelveticaNeue-Thin", "size" : 14.0 } }, "colors" : { "primary" : "70CFFF" , "secondary" : "FCD92B", "title" : "000000", "caption" : "545454", "success" : "95BE22", "warning" : "FFA500", "error" : "BD2C00" }, "components" : { "navigationBar" : { "colors" : { "background" : "84E0FA", "tint" : "979797" }, "fonts" : { "text" : { "name" : "HelveticaNeue-Light", "size" : 14.0 }, "description" : {"name" : "HelveticaNeue-Light", "size" : 12.0 } }, "isTranslucent" : true }, "tabBar" : { "colors" : { "background" : "FFFFFF", "tint" : "FF9600" }, "fonts" : { "text" : { "name" : "HelveticaNeue-Light", "size" : 14.0 } } } } }')

        # Prepare the component content generation test cases.
        (fonts, colors, components) = ([], [], [])
        (fonts, colors, components) = (parseFonts(data['fonts']), parseColors(data['colors']), parseComponents(data['components']))
        testDirectory = os.path.dirname(__file__)

        # Test the component header content generation.
        output = generateComponentsClassHeaderFileContent('OTComponents', sorted(components, key = lambda x: x.key))
        filePath = os.path.join(testDirectory, 'Validation/OTComponents.h.test')
        with open(filePath) as file:
            self.assertEqual(output, file.read())

        # Test the font main content generation.
        output = generateComponentsClassMainFileContent('OTComponents', sorted(components, key = lambda x: x.key))
        filePath = os.path.join(testDirectory, 'Validation/OTComponents.m.test')
        with open(filePath) as file:
            self.assertEqual(output, file.read())
