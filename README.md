<img src="OriginateThemeLogo.png" alt="OriginateTheme Logo" width="500"/>
<hr />
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org)
<br />
> **OriginateTheme** is a lightweight user interface theming framework.

# About OriginateTheme

OriginateTheme introduces the concept of a `theme`. A `theme` is specified in a `JSON` file and describes the basic look and feel of your application. After integrating the `OriginateTheme` framework into your project the specified `JSON` file will automatically get parsed and via a code generation phase transformed to accessible `Objective-C` classes. These created or modified classes are added to the `OriginateTheme` framework before each source code compilation.

The following example displays the basic structure of a `JSON` file which can be read by the `OriginateTheme` framework.
```javascript
{
    "fonts" : {
        "default" : {
            "name" : "HelveticaNeue",
            "size" : 14.0
        },
        "defaultBold" : {
            "name" : "HelveticaNeue-Bold",
            "size" : 14.0
        },
        "defaultLight" : {
            "name" : "HelveticaNeue-Light",
            "size" : 14.0
        },
        "defaultItalic" : {
            "name" : "HelveticaNeue-Thin",
            "size" : 14.0
        },
        ...
    },
    "colors" : {
        "primary" : "70CFFF",
        "secondary" : "FCD92B",
        "success" : "95BE22",
        "warning" : "FFA500",
        "error" : "BD2C00",
        ...
    },
    "components" : {
        "navigationBar" : {
            "colors" : {
                "background" : "84E0FA",
                "tint" : "000000",
                ...
            },
            "fonts" : {
                "text" : {
                    "name" : "HelveticaNeue-Light",
                    "size" : 14.0
                },
                "description" : {
                    "name" : "HelveticaNeue-Light",
                    "size" : 12.0
                },
                ...
            }
        },
        "tabBar" : {
            "colors" : {
                "background" : "FFFFFF",
				"tint" : "FF9600",
				...
            },
            "fonts" : {
                "text" : {
                    "name" : "HelveticaNeue-Light",
                    "size" : 14.0
                },
                ...
            }
        }
        ...
    }
}
```

## Concept of the OTTheme Class
Adding the framework to the project will allow a user to create a new instance of an `OTTheme` class. This class exposes the properties `fonts`, `colors` and `components`. Each of these properties are references to automatically created classes which provide access to the defined styles in the `JSON` file.

```objective-c
@property (nonatomic, strong, readonly) OTColors *colors;
@property (nonatomic, strong, readonly) OTComponents *components;
@property (nonatomic, strong, readonly) OTFonts *fonts;
```

As an example the `colors` property of the `OTTheme` instance is of type `OTColors` and exposes the defined color styles. 

Inside the `OTColors` instance these styles can be accessed by generated property accessors which look as the following:

```objective-c
@property (nonatomic, strong, readwrite) UIColor *errorColor;
@property (nonatomic, strong, readwrite) UIColor *primaryColor;
@property (nonatomic, strong, readwrite) UIColor *secondaryColor;
@property (nonatomic, strong, readwrite) UIColor *successColor;
@property (nonatomic, strong, readwrite) UIColor *warningColor;
```

Next to simply exposing the aforementioned properties, the class `OTTheme` also provides a custom initializer with the declaration:
```objective-c
- (instancetype)initWithStyleDefinitionFileAtURL:(NSURL *)URL;
```

The parameter `URL` is a path to a `JSON` file stored on disk. This `JSON` file can exist already during source code compilation or created dynamically while application runtime. In case the `JSON` file contains the same basic structure consisting of `colors`, `components` and `fonts` it is possible to override theme styles dynamically on runtime. If only a subset of keys are overwritten the at compile time defined styles will be used as fallback. 

This will allow customization of the `OriginateTheme` framework also after submitting or distributing the application.


# Requirements
- iOS 8.0+

# Installation with CocoaPods
Add the following lines to your `Podfile` and run `pod install`.

```ruby
source 'https://github.com/Originate/CocoaPods.git'
pod 'OriginateTheme'
```

# Usage

## Add User-Defined Setting
* Navigate to your projects' `Build Settings`
* Press the `+` button on the top
* As `key` use `OTTHEME` and as `value` the path to the JSON file specifying the theme<br>
e.g. `$(SRCROOT)/Themes/Local.json`

## Add or Move Run Script Phase
* While running `pod install` a new run script phase should have been added to your project.
* Navigate to your projects' `Build Phases`
* Move to the created run script phase with the name `[OT] Generate Theme Files` above `Compile Sources` using drag and drop
* In case the run script phase was not created automatically press the `+` button on the top
* Press `New Run Script Phase`
* Move the created run script phase above `Compile Source` by drag and drop
* As content insert the following:

```
"${PODS_ROOT}/OriginateTheme/OriginateTheme/Scripts/ot_generator.py" -i "${OTTHEME}" -o "${PODS_ROOT}/OriginateTheme/OriginateTheme/Sources/Classes/"
```

## Import the Framework

Add the following line wherever you want to access the framework:
```objective-c
@import OriginateTheme;
```

# License
**OriginateTheme** is available under the MIT license. See the LICENSE file for more information.
