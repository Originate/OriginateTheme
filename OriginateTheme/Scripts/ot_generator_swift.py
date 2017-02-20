import string
from ot_generator_utils import *
from ot_generator_templates import *

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
    """
        Returns Swift statement for defining a variable in structs/classes.
        Follows the format: "var $varName: varType"

        Parameters
        -----------
        varName: String
            The name of the var
        varType: String
            The type of the var
    """
    return string.Template(varTemplate).substitute({'name': varName, 'type': varType})

def otLazyComponentVar(varName, varType = None):
    """
        Returns code for Swift lazy loaded Originate Theme component.
        This component must implement the convenience init $varType(dictionary: ThemeDefinition)

        Parameters
        -----------
        varName: String
            The name of the var
        varType: String
            The type of the var.  If ommited, defaults to varName with first letter capitalized
    """
    theType = varType if varType else upcaseFirstLetter(varName)
    return string.Template(otLazyVarTemplate).substitute({'name': varName, 'type': theType})

def otComputationWith(convenienceConstructor, keyPath, dictionary, fallback):
    """
        Returns code for instantiating an object with $convenience("$keyPath", dictionary: $dictionary, fallback: $fallback)

        Parameters
        -----------
        convenienceConstructor: String
            Convenience constructor.  Usually the type name.
        keyPath: String
            Key path for use in ThemeDefinition
        dictionary: String
            dictionary that defines the ThemeDefinition
        fallback: String
            Swift instance for return value for fallback
    """
    return string.Template(otComputationTemplate).substitute({'convenience': convenienceConstructor, 'path': keyPath, 'dict': dictionary, 'fb': fallback})

def computedPropertyWith(varName, varType, computation):
    """
        Returns code for a computed property.

        Parameters
        -----------
        varName: String
            The name of the property
        varType: String
            The type of the property
        computation: String
            The body implmentation of the computed property without the return statement.
    """
    return string.Template(computedStaticPropertyTemplate).substitute({'var': varWith(varName,varType), 'comp': computation})

def uiColorWithColor(color):
    """
        Returns code to instantiate a UIColor object.

        Parameters
        -----------
        color: Color Object
            The source Color
    """
    return "UIColor.color(\"%s\")" % color.code

def swiftFontInstanceWith(font):
    """
        Returns code to instantiate a UIFont object.

        Parameters
        -----------
        font: Font Object
            The source Font
    """
    return string.Template(fontTemplate).substitute({'fontName': font.name, 'fontSize': font.size})


def nsNumberWithBool(bool):
    """
        Returns code for NSNumber representing Bool

        Parameters
        -----------
        bool: Bool Object
            The source Bool
    """
    return "NSNumber(value: %s)" % str(bool.boolValue).lower()

def cgPointValue(point):
    """
        Returns code for NSValue representing Point

        Parameters
        -----------
        poinht: Point Object
            The source Point
    """
    return "NSValue(cgPoint: CGPoint(x: %s, y: %s))" % (point.x, point.y)

def uiEdgeInsetsValueWithInsets(insets):
    """
        Returns code for NSValue representing EdgeInset

        Parameters
        -----------
        insets: EdgeInset Object
            The source EdgeInset
    """
    return "NSValue(uiEdgeInsets: UIEdgeInsets(top: %s, left: %s, bottom: %s, right: %s))" % (insets.top, insets.left, insets.bottom, insets.right)

def cgRectValueWithRect(rect):
    """
        Returns code for NSValue representing Rect

        Parameters
        -----------
        insets: Rect Object
            The source Rect
    """
    return "NSValue(cgRect: CGRect(x: %s, y: %s, width: %s, height: %s))" % (rect.x, rect.y, rect.width, rect.height)

def createColorProperty(color, prefix = None):
    """
        Returns code for UIColor property

        Parameters
        -----------
        color: Color Object
            The source Color
    """
    keyPath = prefixKeyPath(prefix, 'colors.'+color.key)
    value = otComputationWith('UIColor.color', keyPath, 'dictionary', uiColorWithColor(color))
    return computedPropertyWith(color.key, 'UIColor', value)


def createFontProperty(font, prefix = None):
    """
        Returns code for UIFont property

        Parameters
        -----------
        color: Font Object
            The source Font
    """
    keyPath = prefixKeyPath(prefix, 'fonts.'+font.key)
    value = otComputationWith('UIFont.font', keyPath, 'dictionary', swiftFontInstanceWith(font)+'!')
    return computedPropertyWith(font.key, 'UIFont', value)

def createBoolProperty(bool, prefix = None):
    """
        Returns code for Bool property

        Parameters
        -----------
        color: Bool Object
            The source Bool
    """
    keyPath = prefixKeyPath(prefix, 'bools.'+bool.key)
    value = otComputationWith('NSNumber.number', keyPath, 'dictionary', nsNumberWithBool(bool))
    return computedPropertyWith(bool.key, 'Bool', value+'.boolValue')

def createPointProperty(point, prefix = None):
    """
        Returns code for CGPoint property

        Parameters
        -----------
        color: Point Object
            The source Point
    """
    keyPath = prefixKeyPath(prefix, 'points.'+point.key)
    value = otComputationWith('NSValue.value', keyPath, 'dictionary', cgPointValue(point))
    return computedPropertyWith(point.key, 'CGPoint', value+'.cgPointValue')

def createUIEdgeInsetProperty(insets, prefix = None):
    """
        Returns code for UIEdgeInsets property

        Parameters
        -----------
        color: EdgeInset Object
            The source EdgeInset
    """
    keyPath = prefixKeyPath(prefix, 'insets.'+insets.key)
    value = otComputationWith('NSValue.value', keyPath, 'dictionary', uiEdgeInsetsValueWithInsets(insets))
    return computedPropertyWith(insets.key, 'UIEdgeInsets', value+'.uiEdgeInsetsValue')

def createCGRectProperty(rect, prefix = None):
    """
        Returns code for CGRect property

        Parameters
        -----------
        color: Rect Object
            The source Rect
    """
    keyPath = prefixKeyPath(prefix, 'rects.'+rect.key)
    value = otComputationWith('NSValue.value', keyPath, 'dictionary', cgRectValueWithRect(rect))
    return computedPropertyWith(rect.key, 'CGRect', value+'.cgRectValue')

def structWithBody(structName, structBody):
    """
        Returns struct code

        Parameters
        -----------
        structName: String
            The name of the struct
        structBody: String
            The body of the struct
    """
    return string.Template(structTemplate).substitute({'name': structName, 'body': structBody})

def structWithItems(structName, implementationItems):
    """
        Returns struct code

        Parameters
        -----------
        structName: String
            The name of the struct
        implementationItems: [String]
            Places all implementationItems within body of struct, separated by one line
    """
    joined = '\n\n'.join(implementationItems)
    body = indent(joined, tabLength)
    return structWithBody(structName, body)

def otThemeObjectInitWithItems(items = [otThemeObjectStandardInitLine]):
    """
        Returns Originate Theme init with dictionary code plus other

        Parameters
        -----------
        items: [String]
            Initialization body statements.  Defaults to "self.dictionary = dictionary"
    """
    joined = '\n'.join(items)
    initialization = indent(joined, tabLength)
    return string.Template(otThemeObjectInitTemplate).substitute({'body': initialization})

def otStructWithItems(structName, items):
    """
        Returns Originate Theme struct with init with dictionary code

        Parameters
        -----------
        structName: String
            The name of the struct

        items: [String]
            Implmentation items in struct body
    """
    implementationItems = [varWith('dictionary', 'ThemeDefinition')]
    implementationItems.extend(items)
    implementationItems.append(otThemeObjectInitWithItems())
    return structWithItems(structName, implementationItems)

def createColorsTheme(colors):
    """
        Returns Originate Theme Colors struct

        Parameters
        -----------
        color: [Color]
            List of Color objects
    """
    return otStructWithItems("Colors", [createColorProperty(c) for c in colors])

def createFontsTheme(fonts):
    """
        Returns Originate Theme Fonts struct

        Parameters
        -----------
        color: [Font]
            List of Font objects
    """
    return otStructWithItems("Fonts", [createFontProperty(f) for f in fonts])

def createComponentStruct(component):
    """
        Returns a component struct

        Parameters
        -----------
        component: Component
            The source Component
    """
    structName = upcaseFirstLetter(component.key)
    fonts = [createFontProperty(f, 'components.'+component.key) for f in component.fonts]
    colors = [createColorProperty(c, 'components.'+component.key) for c in component.colors]
    bools = [createBoolProperty(b, 'components.'+component.key) for b in component.bools]
    points = [createPointProperty(p, 'components.'+component.key) for p in component.points]
    insets = [createUIEdgeInsetProperty(i, 'components.'+component.key) for i in component.insets]
    rects = [createCGRectProperty(r, 'components.'+component.key) for r in component.rects]

    componentVars = []
    componentVars.extend(fonts)
    componentVars.extend(colors)
    componentVars.extend(bools)
    componentVars.extend(points)
    componentVars.extend(insets)
    componentVars.extend(rects)
    return (otStructWithItems(structName, componentVars))

def createComponentsTheme(components):
    """
        Returns an Originate Theme Components struct that aggregates the components

        Parameters
        -----------
        components: [Component]
            The source Component objects to aggreate into a Components theme file
    """
    componentsInterface = [otLazyComponentVar(comp.key) for comp in components]
    componentImplementations = [createComponentStruct(comp) for comp in components]
    componentsStruct = [otStructWithItems('Components', componentsInterface)]
    componentsStruct.extend(componentImplementations)
    return '\n\n'.join(componentsStruct)

def generateSwiftFile(code):
    return swiftTemplate() + code + '\n'
