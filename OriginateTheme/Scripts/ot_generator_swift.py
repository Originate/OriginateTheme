import string
from ot_generator import upcaseFirstLetter

structTemplate = """public struct $name {
$body
}"""

varTemplate = """var $name: $type"""

otLazyVarTemplate = """\
lazy var $name: $type = {
    return $type(dictionary: self.dictionary)
}()"""

computedStaticPropertyTemplate ="""public $var {
    return $comp
}"""

computedStaticPropertyTemplate ="""public $var {
    return $comp
}"""

otComputationTemplate = """$convenience("$path", dictionary: $dict, fallback: $fb)"""

fontTemplate = """UIFont(name: "$fontName", size: $fontSize)"""

otThemeObjectInitTemplate = """public init(dictionary: ThemeDefinition = [:]) {
$body
}"""

otThemeObjectStandardInitLine = "self.dictionary = dictionary"

tabLength = 4

def varWith(varName, varType):
    return string.Template(varTemplate).substitute({'name': varName, 'type': varType})

def otLazyComponentVar(varName, varType = None):
    theType = varType if varType else upcaseFirstLetter(varName)
    return string.Template(otLazyVarTemplate).substitute({'name': varName, 'type': theType})

def otComputationWith(convenienceConstructor, keyPath, dictionary, fallback):
    return string.Template(otComputationTemplate).substitute({'convenience': convenienceConstructor, 'path': keyPath, 'dict': dictionary, 'fb': fallback})

def computedPropertyWith(varName, varType, computation):
    return string.Template(computedStaticPropertyTemplate).substitute({'var': varWith(varName,varType), 'comp': computation})

def structWithBody(structName, structBody):
    return string.Template(structTemplate).substitute({'name': structName, 'body': structBody})

def indent(string, numSpaces):
    return  '\n'.join(["".rjust(numSpaces)+s for s in string.split('\n')])

def uiColorWithColor(color):
    return "UIColor.color(\"%s\")" % color.code

def createColorProperty(color):
    value = otComputationWith('UIColor.color', 'colors.'+color.key, 'dictionary', uiColorWithColor(color))
    return computedPropertyWith(color.key, 'UIColor', value)

def NSNumberWithBool(bool):
    return "NSNumber(value: %s)" % str(bool.boolValue).lower()

def cgPointValue(point):
    return "NSValue(cgPoint: CGPoint(x: %s, y: %s))" % (point.x, point.y)

def uiEdgeInsetsValueWithInsets(insets):
    return "NSValue(uiEdgeInsets: UIEdgeInsets(top: %s, left: %s, bottom: %s, right: %s))" % (insets.top, insets.left, insets.bottom, insets.right)

def cgRectValueWithRect(rect):
    return "NSValue(cgRect: CGRect(x: %s, y: %s, width: %s, height: %s))" % (rect.x, rect.y, rect.width, rect.height)

def createBoolProperty(bool):
    value = otComputationWith('NSNumber.number', 'bool.'+bool.key, 'dictionary', NSNumberWithBool(bool))
    return computedPropertyWith(bool.key, 'Bool', value+'.boolValue')

def createPointProperty(point):
    value = otComputationWith('NSValue.value', 'point.'+point.key, 'dictionary', cgPointValue(point))
    return computedPropertyWith(point.key, 'CGPoint', value+'.cgPointValue')

def createUIEdgeInsetProperty(insets):
    value = otComputationWith('NSValue.value', 'insets.'+insets.key, 'dictionary', uiEdgeInsetsValueWithInsets(insets))
    return computedPropertyWith(insets.key, 'UIEdgeInsets', value+'.uiEdgeInsetsValue')

def createCGRectProperty(rect):
    value = otComputationWith('NSValue.value', 'rects.'+rect.key, 'dictionary', cgRectValueWithRect(rect))
    return computedPropertyWith(rect.key, 'CGRect', value+'.cgRectValue')

def swiftFontInstanceWith(font):
    return string.Template(fontTemplate).substitute({'fontName': font.name, 'fontSize': font.size})

def createFontProperty(font):
    value = otComputationWith('UIFont.font', 'fonts.'+font.key, 'dictionary', swiftFontInstanceWith(font)+'!')
    return computedPropertyWith(font.key, 'UIFont', value)

def structWithItems(structName, implementationItems):
    joined = '\n\n'.join(implementationItems)
    body = indent(joined, tabLength)
    return structWithBody(structName, body)

def otThemeObjectInitWithItems(items = [otThemeObjectStandardInitLine]):
    joined = '\n'.join(items)
    initialization = indent(joined, tabLength)
    return string.Template(otThemeObjectInitTemplate).substitute({'body': initialization})

def otThemObjectFactoryInit(type, dictionary):
    "%s(dictionary: %s)" % (type, dictionary)
    return "NavigationBar(dictionary: dictionary)"

def setValueStatement(receiver, aProperty, value):
    return "%s.%s = %s" % (receiver, aProperty, value)

otThemeObjectDictionaryVar = varWith('dictionary', 'ThemeDefinition')

def createColorStruct(color):
    implementationItems = [otThemeObjectDictionaryVar, createColorProperty(color), otThemeObjectInitWithItems()]
    return structWithItems("Colors", implementationItems)

def createFontStruct(font):
    implementationItems = [otThemeObjectDictionaryVar, createFontProperty(font), otThemeObjectInitWithItems()]
    return structWithItems("Fonts", implementationItems)

def createOTStructWithImplemenationItems(structName, items):
    actualItems = [otThemeObjectDictionaryVar]
    actualItems.extend(items)
    actualItems.append(otThemeObjectInitWithItems())
    return structWithItems(structName, actualItems)

def createComponentStruct(component):
    # for every component, make a struct
    structName = upcaseFirstLetter(component.key)
    fonts = [createFontProperty(f) for f in component.fonts]
    colors = [createColorProperty(c) for c in component.colors]
    bools = [createBoolProperty(b) for b in component.bools]
    points = [createPointProperty(p) for p in component.points]
    insets = [createUIEdgeInsetProperty(i) for i in component.insets]
    rects = [createCGRectProperty(r) for r in component.rects]

    componentVars = []
    componentVars.extend(fonts)
    componentVars.extend(colors)
    componentVars.extend(bools)
    componentVars.extend(points)
    componentVars.extend(insets)
    componentVars.extend(rects)
    return (createOTStructWithImplemenationItems(structName, componentVars))

def createAggregatedComponents(name, components):
    componentsInterface = [otLazyComponentVar(comp.key) for comp in components]
    componentImplementations = [createComponentStruct(comp) for comp in components]
    componentsStruct = [createOTStructWithImplemenationItems('Components', componentsInterface)]
    componentsStruct.extend(componentImplementations)
    return '\n\n'.join(componentsStruct)
