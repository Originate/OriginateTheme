#!/usr/bin/python

# -*- coding: utf-8 -*-

import getopt
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
            a valid font object a name and size property has to be available.
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
            print 'Color with key "' + key + '" is not specified with a valid hex color code.'
            continue
        results.append(Color(key, value))
    return results

def parseComponents(components):
    """
        Method for parsing components from of a JSON object.

        Parameters
        ----------
        components: Object
            Object containing component defintions. Each component definition
            can have multiple colors and fonts declared. The key for the colors
            is colors and the key for the fonts is fonts. The requirements for these
            objects are the same as for the parseFonts: or parseColors: method.
    """

    results = []
    for key, value in components.iteritems():
        fonts = []
        colors = []

        if 'fonts' in value:
            fonts = parseFonts(value['fonts'])

        if 'colors' in value:
            colors = parseColors(value['colors'])
        results.append(Component(key, fonts, colors))
    return results

######################
##### Generators #####
######################

def upcaseFirstLetter(s):
    if len(s) > 0:
        return s[0].upper() + s[1:]
    return s

def createStrongUIFontReadOnlyProperty(font):
    return '@property (nonatomic, strong, readonly) UIFont *' + font.key + 'Font;'

def createStrongUIFontReadWriteProperty(font):
    return '@property (nonatomic, strong, readwrite) UIFont *' + font.key + 'Font;'

def createFontPropertyKeyPathKey(font):
    return 'OTHFonts' + upcaseFirstLetter(font.key) + 'KeyPathKey'

def createFontPropertyKeyPathKeyDefinition(font):
    return 'NSString * const ' + createFontPropertyKeyPathKey(font) + ' = @"fonts.' + font.key + '";'

def createFontGetter(font):
    getter = """
- (UIFont *)$fontKey {
    if (!_$fontKey) {
        _$fontKey = [UIFont fontForKeyPath:$fontKeyPathKey
                                    source:self.definition
                                  fallback:[UIFont fontWithName:@"$fontName" size:$fontSize]];
    }

    return _$fontKey;
}
"""

    return string.Template(getter).substitute({ 'fontKey' : font.key + 'Font', 'fontKeyPathKey' : createFontPropertyKeyPathKey(font), 'fontName' : font.name , 'fontSize' : font.size })

def generateFontsOutput(outputDirectory, fonts):

    # Generate the OriginateThemeFonts.h file.
    with open('./Templates/OriginateThemeFonts.h', 'r') as headerFile:
        # Template Source.
        template = string.Template(headerFile.read())

        # Create the public properties.
        OriginateThemeFontsPublicProperties = map(createStrongUIFontReadOnlyProperty, fonts)

        # Substitute the properties.
        result = template.substitute({'OriginateThemeFontsPublicProperties' : '\n'.join(OriginateThemeFontsPublicProperties)})

        # Store the generated file in the output directory.
        with open(outputDirectory + 'OriginateThemeFonts.h', 'wb') as outputFile:
            outputFile.write(result)

    # Generate the OriginateThemeFonts.m file.
    with open('./Templates/OriginateThemeFonts.m', 'r') as mainFile:
        # Template Source.
        template = string.Template(mainFile.read())

        # Create the properties' keys.
        OriginateThemeFontsPropertiesKeyPathKeys = map(createFontPropertyKeyPathKeyDefinition, fonts)

        # Create the private properties.
        OriginateThemeFontsPrivateProperties = map(createStrongUIFontReadWriteProperty, fonts)

        # Create the properties' getters.
        OriginateThemeFontsPropertiesGetters = map(createFontGetter, fonts)

        # Substitute the properties.
        result = template.substitute({'OriginateThemeFontsPropertiesKeyPathKeys' : '\n'.join(OriginateThemeFontsPropertiesKeyPathKeys), 'OriginateThemeFontsPrivateProperties' : '\n'.join(OriginateThemeFontsPrivateProperties), 'OriginateThemeFontsPropertiesGetters' : '\n'.join(OriginateThemeFontsPropertiesGetters)})

        # Store the generated file in the output directory.
        with open(outputDirectory + 'OriginateThemeFonts.m', 'wb') as outputFile:
            outputFile.write(result)

    return

def createStrongUIColorReadOnlyProperty(color):
    return '@property (nonatomic, strong, readonly) UIColor *' + color.key + 'Color;'

def createStrongUIColorReadWriteProperty(color):
    return '@property (nonatomic, strong, readwrite) UIColor *' + color.key + 'Color;'

def createColorPropertyKeyPathKey(color):
    return 'OTHColors' + upcaseFirstLetter(color.key) + 'KeyPathKey'

def createColorPropertyKeyPathKeyDefinition(color):
    return 'NSString * const ' + createColorPropertyKeyPathKey(color) + ' = @"colors.' + color.key + '";'

def createColorGetter(color):
    getter = """
- (UIColor *)$colorKey {
    if (!_$colorKey) {
        _$colorKey = [UIColor colorForKeyPath:$colorKeyPathKey
                                       source:self.definition
                                     fallback:[UIColor oth_hex:0x$colorCode]];
    }

    return _$colorKey;
}"""

    return string.Template(getter).substitute({ 'colorKey' : color.key + 'Color', 'colorKeyPathKey' : createColorPropertyKeyPathKey(color), 'colorCode' : color.code})

def generateColorsOutput(outputDirectory, colors):

    # Generate the OriginateThemeColors.h file.
    with open('./Templates/OriginateThemeColors.h', 'r') as headerFile:
        # Template Source.
        template = string.Template(headerFile.read())

        # Create the public properties.
        OriginateThemeColorsPublicProperties = map(createStrongUIColorReadOnlyProperty, colors)

        # Substitute the properties.
        result = template.substitute({'OriginateThemeColorsPublicProperties' : '\n'.join(OriginateThemeColorsPublicProperties)})

        # Store the generated file in the output directory.
        with open(outputDirectory + 'OriginateThemeColors.h', 'wb') as outputFile:
            outputFile.write(result)

    # Generate the OriginateThemeColors.m file.
    with open('./Templates/OriginateThemeColors.m', 'r') as mainFile:
        # Template Source.
        template = string.Template(mainFile.read())

        # Create the properties' keys.
        OriginateThemeColorsPropertiesKeyPathKeys = map(createColorPropertyKeyPathKeyDefinition, colors)

        # Create the private properties.
        OriginateThemeColorsPrivateProperties = map(createStrongUIColorReadWriteProperty, colors);

        # Create the properties' getters.
        OriginateThemeColorsPropertiesGetters = map(createColorGetter, colors)

        # Substitute the properties.
        result = template.substitute({'OriginateThemeColorsPropertiesKeyPathKeys' : '\n'.join(OriginateThemeColorsPropertiesKeyPathKeys), 'OriginateThemeColorsPrivateProperties' : '\n'.join(OriginateThemeColorsPrivateProperties), 'OriginateThemeColorsPropertiesGetters' : '\n'.join(OriginateThemeColorsPropertiesGetters)})

        # Store the generated file in the output directory.
        with open(outputDirectory + 'OriginateThemeColors.m', 'wb') as outputFile:
            outputFile.write(result)

    return

def generateComponentsOutput(outputDirectory, components):

    # Generate the

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
    fonts = []
    colors = []
    components = []

    # Extract the inputFile and outputDirectory.
    (inputFile, outputDirectory) = parseArguments(argv)

    # Open the .JSON file and parse the fonts, colors and components.
    with open(inputFile, 'r') as file:
        try:
            data = json.load(file, 'utf-8')

            # Parse fonts.
            if 'fonts' in data:
                fonts = parseFonts(data['fonts'])

            # Parse colors.
            if 'colors' in data:
                colors = parseColors(data['colors'])

            # Parse components.
            if 'components' in data:
                components = parseComponents(data['components'])

        except ValueError:
            print 'Decoding JSON input file failed!'
            sys.exit()

    # Create the fonts, colors and components output files.
    generateFontsOutput(outputDirectory, sorted(fonts, key = lambda x: x.key))
    generateColorsOutput(outputDirectory, sorted(colors, key = lambda x: x.key))
    generateComponentsOutput(outputDirectory, sorted(components, key = lambda x: x.key))

if __name__ == "__main__":
    main(sys.argv[1:])
