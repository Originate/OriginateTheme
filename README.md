<img src="OriginateThemeLogo.png" alt="OriginateTheme Logo" width="500"/>
<hr />
[![Build Status](https://travis-ci.org/Originate/OriginateTheme.svg?branch=master)](https://travis-ci.org/Originate/OriginateTheme)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org)
<br />
> **OriginateTheme** is a lightweight user interface theming framework.

# About OriginateTheme

OriginateTheme introduces the concept of a `theme`. A `theme` is specified in a `JSON` file and describes the basic look and feel of your application. After integrating the `OriginateTheme` framework into your project, the specified `JSON` file will be automatically parsed and transformed to accessible `Objective-C` classes via a code generation phase. These created or modified classes are added to the `OriginateTheme` framework before each source code compilation.

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
        "primary" : "70CFFFFF",
        "secondary" : "FCD92B",
        "success" : "95BE22",
        "warning" : "FFA500EE",
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
Adding the framework to the project will allow a user to create a new instance of an `OTTheme` class. This class exposes the properties `fonts`, `colors` and `components`. Each of these properties are references to automatically created classes, which provide access to the defined styles in the `JSON` file.

```objective-c
@property (nonatomic, strong, readonly) OTColors *colors;
@property (nonatomic, strong, readonly) OTComponents *components;
@property (nonatomic, strong, readonly) OTFonts *fonts;
```

As an example, the `colors` property of the `OTTheme` instance is of type `OTColors` and exposes the defined color styles.

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

The parameter `URL` is a path to a `JSON` file stored on disk. This `JSON` file can exist already during source code compilation or created dynamically at application runtime. In case the `JSON` file contains the same basic structure consisting of `colors`, `components` and `fonts`, it is possible to override theme styles dynamically at runtime. If only a subset of keys are overwritten, the compile-time defined styles will be used as fallback.

This allows (remote) customization of the themes after submitting or distributing the application to the App Store.


# Requirements
- iOS 8.0+

# Installation with CocoaPods

1. Create a .json theme file. Optionally, add it to your app target for convenient editing in Xcode.
2. Add the following lines to your `Podfile`.

  ```ruby
  source 'https://github.com/Originate/CocoaPods.git'
  pod 'OriginateTheme'
  ```
  
3. Add the [`originate_theme.rb`](OriginateTheme/Scripts/originate_theme.rb) helper file somewhere convenient within your project.
4. Add the following `post_install` hook to your `Podfile`. Reference the `.json` file and `originate_theme.rb` appropriately. These additional steps are required because of the code generation.

  ```ruby
  require_relative 'scripts/cocoapods/originate_theme.rb'

  post_install do |installer|
    install_originatetheme(installer: installer, json_path: path + '../Themes/Local.json')
  end
  ```

If you wish to perform the additional modifications manually, skip steps 3 and 4 and add the following to your Xcode project:

**Run Script Build Phase:**

* Project: Pods
* Target: OriginateTheme
* Script: `
  "${PODS_ROOT}/OriginateTheme/OriginateTheme/Scripts/ot_generator.py" -i "${OTTHEME}" -o "${PODS_ROOT}/OriginateTheme/OriginateTheme/Sources/Classes/"`
* Note: Should run before the *Compile Sources* phase

**User-Defined Build Setting:**

* Project: Pods
* Target: OriginateTheme
* Key: `OTTHEME`
* Value: Path to the .json file, ex: `$(SRCROOT)/../Themes/Local.json`

## Import the Framework

Add the following line wherever you want to access the framework:
```objective-c
@import OriginateTheme;
```

# License
**OriginateTheme** is available under the MIT license. See the LICENSE file for more information.
