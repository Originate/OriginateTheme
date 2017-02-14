# import getopt
# import itertools
import json
# import operator
import os
import re
import string
import sys

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
    (inputFile) = parseArguments(argv)

    # Open the .JSON file and parse the fonts, colors and components.
    with open(inputFile, 'r') as file:
        try:
            data = json.load(file, 'utf-8')

        except ValueError:
            print 'Decoding JSON input file failed!'
            sys.exit()


def resolveRef(aRef, data):
    # """
    #     Method for resolving specific referenced values in components against a source object.
    #
    #     Parameters
    #     ----------
    #     data: Object
    #         The source object that defines the components, colors, fonts, etc.
    #     aRef: String
    #         The value of a component that references other properties such as colors and fonts
    #         Must follow format: "$property.specificPropertyName".  Ex. "$colors.primary"
    # """
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
    # """
    #     Method for resolving referenced values in components from a JSON object.
    #
    #     Parameters
    #     ----------
    #     data: Object
    #         Object containing color, font, and component defintions. Each component definition
    #         can use referenced values from the property definitions.  Ex: a color value of $colors.primary
    # """
    components = data['components']
    resolvedComponents = {}
    for componentName, componentProperties in components.iteritems():
        for key, aRef in componentProperties.iteritems():
            data["components"][componentName][key] = resolveRef(aRef, data)
            # resolvedComponents[componentName] = {key: resolveRef(aRef, data)}
            # data["components"].update(resolvedComponents)

    # components.update(resolvedComponents)
