#!/usr/bin/python

# -*- coding: utf-8 -*-

import getopt
import itertools
import json
import operator
import os
import re
import string
import sys

###################
##### Classes #####
###################

class Font():
    def __init__(self, key, name, size):
        self.key = key
        self.name = name
        self.size = size

    def __lt__(self, other):
        return self.key < other.key

class Color():
    def __init__(self, key, code):
        self.key = key
        self.code = code

class Component():
    def __init__(self, key, fonts, colors):
        self.key = key
        self.fonts = fonts
        self.colors = colors

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
    helpString = './otheme.py -i <inputFile> -o <outputDirectory>'

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
    hexPattern = re.compile("^(?:[0-9a-fA-F]{6}){1}$")
    for key, value in colors.iteritems():
        if hexPattern.match(value) is None:
            print 'Color with key "' + key + '" is not properly formatted and has an invalid hex color code.'
            continue
        results.append(Color(key, value))
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
        results.append(Component(key,  sorted(fonts, key = lambda x: x.key),  sorted(colors, key = lambda x: x.key)))
    return results

######################
##### Generators #####
######################

def upcaseFirstLetter(s):
    return s[0].upper() + s[1:] if s else s

def createProperty(referenceType, accessMode, propertyType, propertyName):
    return string.Template('@property (nonatomic, ${referenceType}, ${accessMode}) ${propertyType} *${propertyName};').substitute(locals())

def createPropertyKeyPathKey(prefix, key):
    return 'OTH' + prefix + upcaseFirstLetter(key) + 'KeyPathKey'

def createPropertyKeyPathKeyDefinition(propertyKeyPathKey, propertyKeyPathValue):
    return 'NSString * const ' + propertyKeyPathKey + ' = @"' + propertyKeyPathValue + '";'

def createFontGetter(font, getterName, keyPath):
    getter = """
- (UIFont *)$fontKey
{
    if (!_$fontKey) {
        _$fontKey = [UIFont fontForKeyPath:$fontKeyPathKey
                                    source:self.definition
                                  fallback:[UIFont fontWithName:@"$fontName" size:$fontSize]];
    }

    return _$fontKey;
}"""

    return string.Template(getter).substitute({ 'fontKey' : getterName, 'fontKeyPathKey' : keyPath, 'fontName' : font.name , 'fontSize' : font.size })

def createColorGetter(color, getterName, keyPath):
    getter = """
- (UIColor *)$colorKey
{
    if (!_$colorKey) {
        _$colorKey = [UIColor colorForKeyPath:$colorKeyPathKey
                                       source:self.definition
                                     fallback:[UIColor oth_hex:0x$colorCode]];
    }

    return _$colorKey;
}"""

    return string.Template(getter).substitute({ 'colorKey' : getterName, 'colorKeyPathKey' : keyPath, 'colorCode' : color.code})


def generateUITypeClass(outputDirectory, className, dictionary, uiType, getter):

    dictionary = [] if not dictionary else dictionary

    # Generate the OriginateThemeFonts.h file.
    with open('./Template/OriginateThemeTemplate.h', 'r') as headerFile:
        # Template Source.
        template = string.Template(headerFile.read())

        # Create the public properties.
        OriginateThemeFontsPublicProperties = [createProperty('strong', 'readonly', 'UI' + upcaseFirstLetter(uiType), d.key + upcaseFirstLetter(uiType)) for d in dictionary]

        # Substitute the properties.
        result = template.substitute({'OriginateThemePublicProperties' : '\n'.join(OriginateThemeFontsPublicProperties), 'OriginateThemeClassName' : className})

        # Store the generated file in the output directory.
        with open(outputDirectory + className + '.h', 'wb') as outputFile:
            outputFile.write(result)

    # Generate the OriginateThemeFonts.m file.
    with open('./Template/OriginateThemeTemplate.m', 'r') as mainFile:
        # Template Source.
        template = string.Template(mainFile.read())

        # Create the properties' keys.
        OriginateThemeFontsPropertiesKeyPathKeys = [createPropertyKeyPathKeyDefinition(createPropertyKeyPathKey(upcaseFirstLetter(uiType) + 's', d.key), uiType + 's.' + d.key) for d in dictionary]

        # Create the private properties.
        OriginateThemeFontsPrivateProperties = [createProperty('strong', 'readwrite', 'UI' + upcaseFirstLetter(uiType), d.key + upcaseFirstLetter(uiType)) for d in dictionary]

        # Create the properties' getters.
        OriginateThemeFontsPropertiesGetters = [getter(d, d.key + upcaseFirstLetter(uiType), createPropertyKeyPathKey(upcaseFirstLetter(uiType) + 's', d.key)) for d in dictionary]

        # Substitute the properties.
        result = template.substitute({'OriginateThemePropertiesKeyPathKeys' : '\n'.join(OriginateThemeFontsPropertiesKeyPathKeys), 'OriginateThemePrivateProperties' : '\n'.join(OriginateThemeFontsPrivateProperties), 'OriginateThemePropertiesGetters' : '\n'.join(OriginateThemeFontsPropertiesGetters), 'OriginateThemeClassName' : className})

        # Store the generated file in the output directory.
        with open(outputDirectory + className + '.m', 'wb') as outputFile:
            outputFile.write(result)

    return

def generateComponentsClass(outputDirectory, className, components):

    components = [] if not components else components

    # Component specific lambda functions.
    createComponentPropertyName = lambda componentKey, key, uiType: componentKey + upcaseFirstLetter(key) + upcaseFirstLetter(uiType)
    createPropertyDefinition = lambda componentKey, key, uiType, accessType: createProperty('strong', accessType, 'UI' + upcaseFirstLetter(uiType), createComponentPropertyName(componentKey, key, uiType))

    # Generate the OriginateThemeComponents.h file.
    with open('./Template/OriginateThemeTemplate.h', 'r') as headerFile:
        # Template Source.
        template = string.Template(headerFile.read())

        # Create the public properties.
        OriginateThemePublicProperties = [[[createPropertyDefinition(component.key, c.key, 'color', 'readonly') for c in component.colors], [createPropertyDefinition(component.key, f.key, 'font', 'readonly') for f in component.fonts], ['']] for component in components]
        OriginateThemePublicProperties = list(itertools.chain.from_iterable(itertools.chain.from_iterable((OriginateThemePublicProperties))))

        # Substitute the properties.
        result = template.substitute({'OriginateThemePublicProperties' : '\n'.join(OriginateThemePublicProperties), 'OriginateThemeClassName' : className})

        # Store the generated file in the output directory.
        with open(outputDirectory + className + '.h', 'wb') as outputFile:
            outputFile.write(result)

    # Generate the OriginateThemeComponents.m file.
    with open ('./Template/OriginateThemeTemplate.m', 'r') as mainFile:
        # Template Source.
        template = string.Template(mainFile.read())

        # Create the properties' keys.
        createComponentPropertyKeyPathKey = lambda componentKey, typeKey, typeKeyPath: createPropertyKeyPathKey('Components' + upcaseFirstLetter(componentKey) + upcaseFirstLetter(typeKeyPath), typeKey)
        createComponentKeyPathKeyDefinitions = lambda componentKey, typeKey, typeKeyPath: createPropertyKeyPathKeyDefinition(createComponentPropertyKeyPathKey(componentKey, typeKey, typeKeyPath), 'components.' + componentKey + '.' + typeKeyPath + '.' + typeKey)
        OriginateThemePropertiesKeyPathKeys = [[[createComponentKeyPathKeyDefinitions(component.key, c.key, 'colors') for c in component.colors], [createComponentKeyPathKeyDefinitions(component.key, f.key, 'fonts') for f in component.fonts], ['']] for component in components]
        OriginateThemePropertiesKeyPathKeys = list(itertools.chain.from_iterable(itertools.chain.from_iterable((OriginateThemePropertiesKeyPathKeys))))

        # Create the private properties.
        OriginateThemePrivateProperties = [[[createPropertyDefinition(component.key, c.key, 'color', 'readwrite') for c in component.colors], [createPropertyDefinition(component.key, f.key, 'font', 'readwrite') for f in component.fonts], ['']] for component in components]
        OriginateThemePrivateProperties = list(itertools.chain.from_iterable(itertools.chain.from_iterable((OriginateThemePrivateProperties))))

        # Create the properties' getters.
        OriginateThemePropertiesGetters = [[[createColorGetter(c, createComponentPropertyName(component.key, c.key, 'color'), createComponentPropertyKeyPathKey(component.key, c.key, 'colors')) for c in component.colors], [createFontGetter(f, createComponentPropertyName(component.key, f.key, 'font'), createComponentPropertyKeyPathKey(component.key, f.key, 'fonts')) for f in component.fonts]] for component in components]
        OriginateThemePropertiesGetters = list(itertools.chain.from_iterable(itertools.chain.from_iterable((OriginateThemePropertiesGetters))))

        # Substitute the properties.
        result = template.substitute({'OriginateThemePropertiesKeyPathKeys' : '\n'.join(OriginateThemePropertiesKeyPathKeys), 'OriginateThemePrivateProperties' : '\n'.join(OriginateThemePrivateProperties), 'OriginateThemePropertiesGetters' : '\n'.join(OriginateThemePropertiesGetters), 'OriginateThemeClassName' : className})

        # Store the generated file in the output directory.
        with open(outputDirectory + className + '.m', 'wb') as outputFile:
            outputFile.write(result)

    return

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
    generateUITypeClass(outputDirectory, 'OriginateThemeFonts', sorted(fonts, key = lambda x: x.key), 'font', createFontGetter)
    generateUITypeClass(outputDirectory, 'OriginateThemeColors', sorted(colors, key = lambda x: x.key), 'color', createColorGetter)
    generateComponentsClass(outputDirectory, 'OriginateThemeComponents', sorted(components, key = lambda x: x.key))

if __name__ == "__main__":
    main(sys.argv[1:])

#####################
##### Templates #####
#####################
