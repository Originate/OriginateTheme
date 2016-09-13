#!/usr/bin/python

# -*- coding: utf-8 -*-

import getopt
import json
import os
import sys

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
    return []

def parseColors(colors):
    return []

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
            if 'fonts' in inputFile:
                parseFonts(inputFile['fonts'])

            # Parse colors.
            if 'colors' in inputFile:
                parseColors(inputFile['colors'])

            # Parse components.
            if 'components' in inputFile:
                parseComponents(inputFile['components'])

        except ValueError:
            print 'Decoding JSON input file failed!'
            sys.exit()

if __name__ == "__main__":
    main(sys.argv[1:])
