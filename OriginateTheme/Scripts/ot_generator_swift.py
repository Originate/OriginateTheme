import string

structTemplate = """public struct $name {
$body
}"""
varTemplate = """var $name: $type"""
computedStaticPropertyTemplate ="""public $var {
    return $comp
}"""
otComputationTemplate = """$convenience("$path", dictionary: $dict, fallback: $fb)"""
fontTemplate = """UIFont(name: "$fontName", size: $fontSize)"""

tabLength = 4

def varWith(varName, varType):
    return string.Template(varTemplate).substitute({'name': varName, 'type': varType})

def otComputationWith(convenienceConstructor, keyPath, dictionary, fallback):
    return string.Template(otComputationTemplate).substitute({'convenience': convenienceConstructor, 'path': keyPath, 'dict': dictionary, 'fb': fallback})

def computedPropertyWith(varName, varType, computation):
    return string.Template(computedStaticPropertyTemplate).substitute({'var': varWith(varName,varType), 'comp': computation})

def structWithBody(structName, structBody):
    return string.Template(structTemplate).substitute({'name': structName, 'body': structBody})

def indent(string, numSpaces):
    return  '\n'.join(["".rjust(numSpaces)+s for s in string.split('\n')])

def createColorProperty(color):
    value = otComputationWith('UIColor.color', 'colors.'+color.key, 'dictionary', color.code)
    return computedPropertyWith(color.key, 'UIColor', value)

def swiftFontInstanceWith(font):
    return string.Template(fontTemplate).substitute({'fontName': font.name, 'fontSize': font.size})

def createFontProperty(font):
    value = otComputationWith('UIFont.font', 'fonts.'+font.key, 'dictionary', swiftFontInstanceWith(font))
    return computedPropertyWith(font.key, 'UIFont', value)

def structWithItems(structName, implementationItems):
    joined = '\n\n'.join(implementationItems)
    body = indent(joined, tabLength)
    return structWithBody(structName, body)
