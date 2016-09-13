#!/usr/bin/python

# -*- coding: utf-8 -*-

import getopt
import json
import os
import re
import sys

class Font():
    def __init__(self, key, name, size):
        self.key = key
        self.name = name
        self.size = size

class Color():
    def __init__(self, key, color):
        self.key = key
        self.color = color

class Component():
    def __init__(self, key, fonts, colors):
        self.key = key
        self.fonts = fonts
        self.colors = colors

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
    results = []
    for key, value in fonts.iteritems():
        if 'name' not in value or 'size' not in value:
            print 'Font with key "' + key + '" is not properly formed!'
            continue
        results.append(Font(key, value['name'], value['size']))
    return results

def parseColors(colors):
    results = []
    hexPattern = re.compile("^(?:[0-9a-fA-F]{3}){1,2}$")
    for key, value in colors.iteritems():
        if hexPattern.match(value) is None:
            print 'Color with key "' + key + '" is not specified with a valid hex color code.'
            continue
        results.append(Color(key, value))
    return results

def parseComponents(components):
    return []

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
    #print colors

if __name__ == "__main__":
    main(sys.argv[1:])
