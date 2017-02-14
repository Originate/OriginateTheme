"""
    ot_reference_resolver.py
    Script which resolves references in OriginateTheme class files in a JSON file.

    Arguments
    ----------
        -i: String
            The input JSON file e.g. `Theme.json`.
        -o: String
            The directory where the files should be created in.
"""

import json
import os
import re
import string
import sys
from ot_generator import parseArguments

def resolveJSONFile(inputFile, outputDirectory):
    """
        Method for resolving references in an OriginateTheme JSON file.

        Parameters
        ----------
        inputFile: String
            Path to the .json file containing the theme definitions.
        outputDirectory: String
            Path to the directory where the resolved file should be generated.
    """
    with open(inputFile, 'r') as file:
        try:
            data = json.load(file, 'utf-8')
            resolveComponentReferencesInData(data)
            filePath = outputDirectory + inputFile
            if os.path.isfile(filePath):
                os.chmod(filePath, 0755)
            with open(filePath, 'wb') as outputFile:
                outputFile.write(json.dumps(data, indent=2))
        except ValueError:
            print 'Decoding JSON input file failed!'
            sys.exit()

def resolveRef(aRef, data):
    """
        Method for resolving specific referenced values in components against a source object.

        Parameters
        ----------
        data: Object
            The source object that defines the components, colors, fonts, etc.
        aRef: String
            The value of a component that references other properties such as colors and fonts
            Must follow format: "$property.specificPropertyName".  Ex. "$colors.primary"
    """
    m = re.search('\$(\w+).(\w+)', aRef)
    try:
        (parentKey, key) = (m.group(1), m.group(2))
    except ValueError:
        print "Cannot resolve reference: %s" % aRef
    try:
        return data[parentKey][key]
    except ValueError:
        print "Cannot resolve key path in JSON %s.%s" % ('parentKey', key)
        sys.exit()

def resolveComponentReferencesInData(data):
    """
        Method for resolving referenced values in components from a JSON object.

        Parameters
        ----------
        data: Object
            Object containing color, font, and component defintions. Each component definition
            can use referenced values from the property definitions.  Ex: a color value of $colors.primary
    """
    components = data['components']
    resolvedComponents = {}
    for componentName, componentProperties in components.iteritems():
        for key, aRef in componentProperties.iteritems():
            data["components"][componentName][key] = resolveRef(aRef, data)

def main(argv):
    """
        Method responsible for the program execution.

        Parameters
        ----------
        argv: Array
            Array containing all programs' arguments
    """

    (inputFile, outputFile) = parseArguments(argv)
    resolveJSONFile(inputFile, outputFile)

if __name__ == "__main__":
    main(sys.argv[1:])
