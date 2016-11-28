#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
    otgenerator.py
    Script which creates OriginateTheme class files out of a JSON file.

    Arguments
    ----------
        -i: String
            The input JSON file e.g. `Theme.json`.
        -o: String
            The directory where the files should be created in.
"""

import getopt
import itertools
import json
import operator
import os
import re
import string
import sys

#####################
##### Templates #####
#####################

def headerTemplate():
    """
        Template for an OriginateTheme header file.
    """
    return """//
//  $OriginateThemeClassName.h
//  OriginateTheme
//
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import UIKit;

@interface $OriginateThemeClassName : NSObject

#pragma mark - Properties
$OriginateThemePublicProperties
#pragma mark - Methods
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
"""

def mainTemplate():
    """
        Template for an OriginateTheme main file.
    """
    return """//
//  $OriginateThemeClassName.m
//  OriginateTheme
//
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "$OriginateThemeClassName.h"
#import "UIColor+OTHex.h"
#import "UIColor+OTKeySource.h"
#import "UIFont+OTKeySource.h"

$OriginateThemePropertiesKeyPathKeys
@interface $OriginateThemeClassName ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

$OriginateThemePrivateProperties
@end

@implementation $OriginateThemeClassName

#pragma mark - $OriginateThemeClassName

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self) {
        _definition = dictionary;
    }

    return self;
}

#pragma mark - $OriginateThemeClassName (Properties)
$OriginateThemePropertiesGetters

@end
"""

######################
##### Properties #####
######################

def createFontGetter(font, name, keyPath):
    """
        Creates a new getter to access a OriginateTheme UIFont property.

        Parameters
        -----------
        font: Object
            Object of type 'font'.
        name: String
            The name of the property to create a getter for.
        keyPath: String
            The name of the key path to associated to the property.
    """
    getter = """
- (UIFont *)$name
{
    if (!_$name) {
        _$name = [UIFont fontForKeyPath:$fontKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"$fontName" size:$fontSize]];
    }

    return _$name;
}"""
    return string.Template(getter).substitute({ 'name' : name, 'fontKeyPathKey' : keyPath, 'fontName' : font.name , 'fontSize' : font.size })

def createColorGetter(color, name, keyPath):
    """
        Creates a new getter to access a OriginateTheme UIColor property.

        Parameters
        -----------
        color: Object
            Object of type 'Color'.
        name: String
            The name of the property to create a getter for.
        keyPath: String
            The name of the key path to associated to the property.
    """
    getter = """
- (UIColor *)$name
{
    if (!_$name) {
        _$name = [UIColor colorForKeyPath:$colorKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x$colorCode]];
    }

    return _$name;
}"""
    return string.Template(getter).substitute({ 'name' : name, 'colorKeyPathKey' : keyPath, 'colorCode' : color.code})

def createBoolGetter(bool, name, keyPath):
    """
        Creates a new getter to access a OriginateTheme UIColor property.

        Parameters
        -----------
        bool: Object
        Object of type 'Bool'.
        name: String
        The name of the property to create a getter for.
        keyPath: String
        The name of the key path to associated to the property.
        """
    getter = """
- (BOOL)$name
{
    return [[NSValue valueForKeyPath:$boolKeyPathKey
                              source:self.definition
                            fallback:@($boolValue)] boolValue];
}"""
    return string.Template(getter).substitute({ 'name' : name, 'boolKeyPathKey' : keyPath, 'boolValue' : "YES" if bool.boolValue else "NO"})


###################
##### Classes #####
###################

class Font():
    """
        Class representing all font type information.
    """
    def __init__(self, key, name, size):
        self.key = key
        self.name = name
        self.size = size

class Bool():
    """
        Class representing all bool type information.
    """
    def __init__(self, key, boolValue):
        self.key = key
        self.boolValue = boolValue

class Color():
    """
        Class representing all color type information.
    """
    def __init__(self, key, code):
        self.key = key
        self.code = code

class Component():
    """
        Class representing all component type information.
    """
    def __init__(self, key, fonts, colors, bools):
        self.key = key
        self.fonts = fonts
        self.colors = colors
        self.bools = bools
##################
##### Parser #####
##################

def parseArguments(argv):
    """
        Parse programs' arguments and extract the input file and output directory.

        Parameters
        -----------
        inputFile: String
            Path to the .json file containing the theme definitions.
        outputDirectory: String
            Path to the directory where the new files should be generated.
    """
    inputFile = ''
    outputDirectory = ''
    helpString = './ot_generator.py -i <inputFile> -o <outputDirectory>'

    # Extract the inputFile and outputDirectory arguments.
    try:
        opts, args = getopt.getopt(argv, "hi:o:", ["input=", "output="])
    except getopt.GetoptError:
        print helpString
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print helpString
            sys.exit()
        elif opt in ("-i", "--input"):
            inputFile = arg
        elif opt in ("-o", "--output"):
            outputDirectory = arg

    # Check if inputFile and outputDirectory have concrete values.
    if len(inputFile) is 0 or len(outputDirectory) is 0:
        print helpString
        sys.exit()

    # Check if inputFile is a valid path to a file.
    if os.path.isfile(inputFile) is False:
        print '"' + inputFile + '" does not exist!'
        sys.exit()

    # Check if outputDirectory exists and is a directory.
    if os.path.isdir(outputDirectory) is False:
        print '"' + outputDirectory + '" is not a directory or does not exist.'
        sys.exit()

    return (inputFile, outputDirectory)

def parseFonts(fonts):
    """
        Method for parsing fonts from a JSON object.

        Parameters
        ----------
        fonts: Object
            Object containing font objecs  and their corresponding keys. For being
            a valid font object a name and size property has to be provided
    """
    results = []
    for key, value in fonts.iteritems():
        if 'name' not in value or 'size' not in value:
            print 'Font with key "' + key + '" is not properly formed!'
            continue
        results.append(Font(key, value['name'], value['size']))
    return results

def parseColors(colors):
    """
        Method for parsing colors from a JSON object.

        Parameters
        ----------
        colors: Object
            Object containing six digit hex color codes and their corresponding keys.
            A '#' as prefix for the hex color codes is not allowed.
    """
    results = []
    hexPattern = re.compile("^(?=[0-9a-fA-F]*$)(?:.{6}|.{8})$")
    for key, value in colors.iteritems():
        if hexPattern.match(value) is None:
            print 'Color with key "' + key + '" is not properly formatted and has an invalid hex color code.'
            continue
        if len(value) is 6:
            value = value + 'FF'
        results.append(Color(key, value))
    return results

def parseBools(bools):
    """
        Method for parsing bools from a JSON object.

        Parameters
        ----------
        bools: Object
            Object containing bool values and their corresponding keys.
    """
    results = []
    for key, value in bools.iteritems():
        results.append(Bool(key, value))
    return results

def parseComponents(components):
    """
        Method for parsing components from a JSON object.

        Parameters
        ----------
        components: Object
            Object containing component defintions. Each component definition
            can declare multiple colors and fonts. The key for declared colors
            is colors and the key declared fonts is fonts. The requirements for these
            embeeded objects are the same as for the methods parseFonts: or parseColors:.
    """
    results = []
    for key, value in components.iteritems():
        colors = parseColors(value['colors']) if 'colors' in value else []
        fonts = parseFonts(value['fonts']) if 'fonts' in value else []
        bools = parseBools(extractBoolValues(value))
        results.append(Component(key,  sorted(fonts, key = lambda x: x.key),  sorted(colors, key = lambda x: x.key), sorted(bools, key = lambda x: x.key) ))
    return results

def extractBoolValues(dict):
    bools = {k: v for k, v in dict.iteritems() if type(v) == bool}
    return bools

######################
##### Generators #####
######################

def upcaseFirstLetter(s):
    """
        Method which upercases the first letter of a string.

        Parameters
        -----------
        s: String
            String whose first letter should be upercase.
    """
    return s[0].upper() + s[1:] if s else s

def createProperty(referenceType, accessMode, propertyType, propertyName):
    """
        Convenient method to create a new property definition.

        Parameters
        -----------
        referenceType: String
            The String 'weak', 'strong' or 'copy'.
        accessMode: String
            The String 'readonly' or 'readwrite'.
        propertyType: String
            String representing the type of the property e.g. 'UIColor'.
        propertyName: String
            String for the property name.
    """
    return string.Template('@property (nonatomic, ${referenceType}, ${accessMode}) ${propertyType} *${propertyName};').substitute(locals())

def createValueProperty(accessMode, propertyType, propertyName):
    """
        Convenient method to create a new property definition.

        Parameters
        -----------
        accessMode: String
            The String 'readonly' or 'readwrite'.
        propertyType: String
            String representing the type of the property e.g. 'BOOL'.
        propertyName: String
            String for the property name.
    """
    return string.Template('@property (nonatomic, assign, ${accessMode}) ${propertyType} ${propertyName};').substitute(locals())

def createPropertyKeyPathKey(prefix, key):
    """
        Convenient method to create a new property key path key name.

        Parameters
        -----------
        prefix: String
            String of specifying possible prefix e.g. 'Colors'.
        key: String
            String representing the property key path key.
    """
    return 'OT' + prefix + upcaseFirstLetter(key) + 'KeyPathKey'

def createPropertyKeyPathKeyDefinition(propertyKeyPathKey, propertyKeyPathValue):
    """
        Convenient method to create a new property key path key definition.

        Parameters
        -----------
        propertyKeyPathKey: String
            String specifying the key path key e.g. the result of the method createPropertyKeyPathKey:.
        propertyKeyPathValue: String
            String specifying the value of the key path key e.g. 'colors.primary'.
    """
    return 'NSString * const ' + propertyKeyPathKey + ' = @"' + propertyKeyPathValue + '";'

def generateUITypeClassHeaderFileContent(className, dictionary, uiType, getter):
    """
        Create the content of the header file for an OriginateTheme class specifying font or color definitions.

        Parameters
        -----------
        className: String
            The name of the new class.
        dictionary: Object
            Object containing all key/value pairs for the font or color definitions.
        uiType: String
            The String 'color' or 'font'.
        getter: Function
            A Function generating the property getter files for the specified type.
    """
    # Create the public properties.
    OriginateThemeTypePublicProperties = [createProperty('strong', 'readonly', 'UI' + upcaseFirstLetter(uiType), d.key + upcaseFirstLetter(uiType)) for d in dictionary] + ['']

    # Substitute the properties.
    return string.Template(headerTemplate()).substitute({'OriginateThemePublicProperties' : '\n'.join(OriginateThemeTypePublicProperties), 'OriginateThemeClassName' : className})

def generateUITypeClassMainFileContent(className, dictionary, uiType, getter):
    """
        Create the content of the main file for an OriginateTheme class specifying font or color definitions.

        Parameters
        -----------
        className: String
            The name of the new class.
        dictionary: Object
            Object containing all key/value pairs for the font or color definitions.
        uiType: String
            The String 'color' or 'font'.
        getter: Function
            A Function generating the property getter files for the specified type.
    """
    # Create the properties' keys.
    OriginateThemeTypePropertiesKeyPathKeys = [createPropertyKeyPathKeyDefinition(createPropertyKeyPathKey(upcaseFirstLetter(uiType) + 's', d.key), uiType + 's.' + d.key) for d in dictionary] + ['']

    # Create the private properties.
    OriginateThemeTypePrivateProperties = [createProperty('strong', 'readwrite', 'UI' + upcaseFirstLetter(uiType), d.key + upcaseFirstLetter(uiType)) for d in dictionary] + ['']

    # Create the properties' getters.
    OriginateThemeTypePropertiesGetters = [getter(d, d.key + upcaseFirstLetter(uiType), createPropertyKeyPathKey(upcaseFirstLetter(uiType) + 's', d.key)) for d in dictionary]

    # Substitute the properties.
    return string.Template(mainTemplate()).substitute({'OriginateThemePropertiesKeyPathKeys' : '\n'.join(OriginateThemeTypePropertiesKeyPathKeys), 'OriginateThemePrivateProperties' : '\n'.join(OriginateThemeTypePrivateProperties), 'OriginateThemePropertiesGetters' : '\n'.join(OriginateThemeTypePropertiesGetters), 'OriginateThemeClassName' : className})

def generateUITypeClass(outputDirectory, className, dictionary, uiType, getter):
    """
        Create a new pair of header and main file for an OriginateTheme class specifying font or color definitions.

        Parameters
        -----------
        outputDirectory: String
            String specifying the directory where the result should be saved.
        className: String
            The name of the new class.
        dictionary: Object
            Object containing all key/value pairs for the font or color definitions.
        uiType: String
            The String 'color' or 'font'.
        getter: Function
            A Function generating the property getter files for the specified type.
    """
    dictionary = [] if not dictionary else dictionary

    #############################
    # Generate the header file. #
    #############################

    # Store the generated file in the output directory.
    filePath = outputDirectory + className + '.h'
    if os.path.isfile(filePath):
        os.chmod(filePath, 0755)
    with open(outputDirectory + className + '.h', 'wb') as outputFile:
        outputFile.write(generateUITypeClassHeaderFileContent(className, dictionary, uiType, getter))

    ###########################
    # Generate the main file. #
    ###########################

    # Store the generated file in the output directory.
    filePath = outputDirectory + className + '.m'
    if os.path.isfile(filePath):
        os.chmod(filePath, 0755)
    with open(outputDirectory + className + '.m', 'wb') as outputFile:
        outputFile.write(generateUITypeClassMainFileContent(className, dictionary, uiType, getter))

def generateComponentsClassHeaderFileContent(className, components):
    """
        Create the content of the header file for an OriginateTheme class specifying component definitions.

        Parameters
        -----------
        className: String
            The name of the new class.
        components: Object
            Object containing all key/value pairs for the component definitions.
    """
    # Component specific lambda functions.
    createComponentPropertyName = lambda componentKey, key, uiType:  componentKey + upcaseFirstLetter(key) + upcaseFirstLetter(uiType)
    createPropertyDefinition = lambda componentKey, key, uiType, accessType: createProperty('strong', accessType, 'UI' + upcaseFirstLetter(uiType), createComponentPropertyName(componentKey, key, uiType))
    createValuePropertyDefinition = lambda componentKey, key, objcType, accessType: createValueProperty(accessType, objcType, createComponentPropertyName(componentKey, key, ""))

    # Create the public properties.
    OriginateThemePublicProperties = [[
                                        [createPropertyDefinition(component.key, c.key, 'color', 'readonly') for c in component.colors],
                                        [createPropertyDefinition(component.key, f.key, 'font', 'readonly') for f in component.fonts],
                                        [createValuePropertyDefinition(component.key, b.key, 'BOOL', 'readonly') for b in component.bools],
                                        ['']
                                        ] for component in components]
    OriginateThemePublicProperties = list(itertools.chain.from_iterable(itertools.chain.from_iterable((OriginateThemePublicProperties))))

    # Substitute the properties.
    return string.Template(headerTemplate()).substitute({'OriginateThemePublicProperties' : '\n'.join(OriginateThemePublicProperties), 'OriginateThemeClassName' : className})


def generateComponentsClassMainFileContent(className, components):
    """
        Create the content of the main file for an OriginateTheme class specifying component definitions.

        Parameters
        -----------
        className: String
            The name of the new class.
        components: Object
            Object containing all key/value pairs for the component definitions.
    """
    # Component specific lambda functions.
    createComponentPropertyName = lambda componentKey, key, uiType: componentKey + upcaseFirstLetter(key) + upcaseFirstLetter(uiType)
    createPropertyDefinition = lambda componentKey, key, uiType, accessType: createProperty('strong', accessType, 'UI' + upcaseFirstLetter(uiType), createComponentPropertyName(componentKey, key, uiType))
    createValuePropertyDefinition = lambda componentKey, key, objcType, accessType: createValueProperty(accessType, objcType, createComponentPropertyName(componentKey, key, ""))

    # Create the properties' keys.
    createComponentPropertyKeyPathKey = lambda componentKey, typeKey, typeKeyPath: createPropertyKeyPathKey('Components' + upcaseFirstLetter(componentKey) + upcaseFirstLetter(typeKeyPath), typeKey)
    createComponentKeyPathKeyDefinitions = lambda componentKey, typeKey, typeKeyPath: createPropertyKeyPathKeyDefinition(createComponentPropertyKeyPathKey(componentKey, typeKey, typeKeyPath), 'components.' + componentKey + '.' + typeKeyPath + '.' + typeKey)
    OriginateThemePropertiesKeyPathKeys = [[
                                            [createComponentKeyPathKeyDefinitions(component.key, c.key, 'colors') for c in component.colors],
                                            [createComponentKeyPathKeyDefinitions(component.key, f.key, 'fonts') for f in component.fonts],
                                            [createComponentKeyPathKeyDefinitions(component.key, b.key, 'bools') for b in component.bools],
                                            ['']
                                            ] for component in components]
    OriginateThemePropertiesKeyPathKeys = list(itertools.chain.from_iterable(itertools.chain.from_iterable((OriginateThemePropertiesKeyPathKeys))))

    # Create the private properties.
    OriginateThemePrivateProperties = [[
                                        [createPropertyDefinition(component.key, c.key, 'color', 'readwrite') for c in component.colors],
                                        [createPropertyDefinition(component.key, f.key, 'font', 'readwrite') for f in component.fonts],
                                        ['']
                                        ] for component in components]
    OriginateThemePrivateProperties = list(itertools.chain.from_iterable(itertools.chain.from_iterable((OriginateThemePrivateProperties))))

    # Create the properties' getters.
    OriginateThemePropertiesGetters = [[
                                        [createColorGetter(c, createComponentPropertyName(component.key, c.key, 'color'), createComponentPropertyKeyPathKey(component.key, c.key, 'colors')) for c in component.colors],
                                        [createFontGetter(f, createComponentPropertyName(component.key, f.key, 'font'), createComponentPropertyKeyPathKey(component.key, f.key, 'fonts')) for f in component.fonts],
                                        [createBoolGetter(b, createComponentPropertyName(component.key, b.key, 'bool'), createComponentPropertyKeyPathKey(component.key, b.key, 'bools')) for b in component.bools]
                                        ] for component in components]
    OriginateThemePropertiesGetters = list(itertools.chain.from_iterable(itertools.chain.from_iterable((OriginateThemePropertiesGetters))))

    # Substitute the properties.
    return string.Template(mainTemplate()).substitute({'OriginateThemePropertiesKeyPathKeys' : '\n'.join(OriginateThemePropertiesKeyPathKeys), 'OriginateThemePrivateProperties' : '\n'.join(OriginateThemePrivateProperties), 'OriginateThemePropertiesGetters' : '\n'.join(OriginateThemePropertiesGetters), 'OriginateThemeClassName' : className})

def generateComponentsClass(outputDirectory, className, components):
    """
        Create a new pair of header and main file for an OriginateTheme class specifying component definitions.

        Parameters
        -----------
        outputDirectory: String
            String specifying the directory where the result should be saved.
        className: String
            The name of the new class.
        components: Object
            Object containing all key/value pairs for the component definitions.
    """
    components = [] if not components else components

    #############################
    # Generate the header file. #
    #############################

    # Store the generated file in the output directory.
    filePath = outputDirectory + className + '.h'
    if os.path.isfile(filePath):
        os.chmod(filePath, 0755)
    with open(outputDirectory + className + '.h', 'wb') as outputFile:
        outputFile.write(generateComponentsClassHeaderFileContent(className, components))

    ###########################
    # Generate the main file. #
    ###########################

    # Store the generated file in the output directory.
    filePath = outputDirectory + className + '.m'
    if os.path.isfile(filePath):
        os.chmod(filePath, 0755)
    with open(outputDirectory + className + '.m', 'wb') as outputFile:
        outputFile.write(generateComponentsClassMainFileContent(className, components))

################
##### Main #####
################

def main(argv):
    """
        Method responsible for the program execution.

        Parameters
        ----------
        argv: Array
            Array containing all programs' arguments
    """
    # Initialize variables for extracted fonts, colors and components.
    (fonts, colors, components) = ([], [], [])

    # Extract the inputFile and outputDirectory.
    (inputFile, outputDirectory) = parseArguments(argv)

    # Open the .JSON file and parse the fonts, colors and components.
    with open(inputFile, 'r') as file:
        try:
            data = json.load(file, 'utf-8')
            (fonts, colors, components) = (parseFonts(data['fonts']), parseColors(data['colors']), parseComponents(data['components']))
        except ValueError:
            print 'Decoding JSON input file failed!'
            sys.exit()

    # Create the fonts, colors and components output files.
    generateUITypeClass(outputDirectory, 'OTFonts', sorted(fonts, key = lambda x: x.key), 'font', createFontGetter)
    generateUITypeClass(outputDirectory, 'OTColors', sorted(colors, key = lambda x: x.key), 'color', createColorGetter)
    generateComponentsClass(outputDirectory, 'OTComponents', sorted(components, key = lambda x: x.key))

if __name__ == "__main__":
    main(sys.argv[1:])
