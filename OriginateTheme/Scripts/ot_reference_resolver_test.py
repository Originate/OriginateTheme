#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
    otgenerator.py
    Collection of tests for the ot_generator.py script.
"""

import os
import unittest
import copy
import pprint

from ot_reference_resolver import *

pp = pprint.PrettyPrinter(indent=4)

class ResolveComponentReferencesTestCase(unittest.TestCase):
    def runTest(self):
        data = json.loads("""{
          "colors": {
            "primary": "FFFF00"
          },
          "fonts": {
            "default" : {
                "name" : "HelveticaNeue",
                "size" : "14.0"
            }
          },
          "components": {
            "tabBar": {
              "backgroundColor": "$colors.primary",
              "tabItemFont": "$fonts.default"
            }
          }
        }""")
        expectedData = copy.deepcopy(data)
        expectedData["components"]["tabBar"]["backgroundColor"] = data["colors"]["primary"]
        expectedData["components"]["tabBar"]["tabItemFont"] = data["fonts"]["default"]
        resolveComponentReferencesInData(data)
        self.assertEqual(data, expectedData)

class ResolveReferenceTestCase(unittest.TestCase):
    def runTest(self):
        data = json.loads("""{
          "colors": {
            "primary": "FFFF00"
          },
          "fonts": {
            "default" : {
                "name" : "HelveticaNeue",
                "size" : "14.0"
            }
          },
          "components": {
            "tabBar": {
              "backgroundColor": "$colors.primary",
              "tabItemFont": "$fonts.default"
            }
          }
        }""")
        aRef = data["components"]["tabBar"]["backgroundColor"]
        resolvedRefData = resolveRef(aRef, data)
        expectedData = data["colors"]["primary"]
        self.assertEqual(resolvedRefData, expectedData)
