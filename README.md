# OriginateTheme
[![CI Status](http://img.shields.io/travis/Originate/OriginateUI.svg?style=flat)](https://travis-ci.org/Originate/# OriginateTheme)

> A lightweight user interface theming framework.

Add `User-Defined Build Setting`
```
Key: 	OTTHEME
Value: 	$(SRCROOT)/OriginateTheme-Example/Theme.json (Path to the JSON file containing the specified theme.)
```

Add `New Run Script Phase` before `[Compile Sources]`
```
"${PODS_ROOT}/OriginateTheme/OriginateTheme/Scripts/ot_generator.py" -i "${OTTHEME}" -o "${PODS_ROOT}/OriginateTheme/OriginateTheme/Sources/Classes/"
```

Execute inside the Example directory.
```
./ot_generator.py -i ../../Example/OriginateTheme/StyleDefinition.json -o ../../Pod/Sources/Classes/
```

In case no valid values for keys in JSON these values will be discarded for the file generation.

`theme.json` has to be in same directory as `Info.plist`.

# Installation with CocoaPods
Add the following lines to your Podfile and run `pod install`.

```ruby
source 'https://github.com/Originate/CocoaPods.git'
pod 'OriginateTheme'
```

# Requirements
- iOS 8.0+

# Usage

## Import the Framework

Add the following line wherever you want to access the framework:
```objective-c
@import OriginateTheme;
```

## Themes

OriginateTheme introduces the concept of a `theme`. A theme is specified using `json` and describes the basic look and feel of your application:

```javascript
// Theme.json
{
    "fonts" : {
        "default" : {
            "name" : "HelveticaNeue",
            "size" : 15.0
        },
        "defaultBold" : {
            "name" : "HelveticaNeue-Bold",
            "size" : 15.0
        },
        "defaultLight" : {
            "name" : "HelveticaNeue-Light",
            "size" : 15.0
        },
        ...
    },
    "colors" : {
        "primary" : "EFEFEF",
        "secondary" : "636363",
        ...
    },
    "components" : {
        "navigationBar" : {
            "colors" : {
                "backgroundColor" : "84E0FA",
                "titleColor" : "000000",
                "descriptionColor" : "979797",
                ...
            },
            "fonts" : {
                "textFont" : {
                    "name" : "HelveticaNeue-Light",
                    "size" : 14.0
                },
                "descriptionFont" : {
                    "name" : "HelveticaNeue-Light",
                    "size" : 12.0
                },
                ...
            }              
        },
        "tabBar" : {
            "colors" : {
                "backgroundColor" : "FFFFFF",
                "textColor" : "424242",
                "selectedTextColor" : "4C66A4",
                ...
            },
            "fonts" : {
                "titleFont" : {
                    "name" : "HelveticaNeue-Light",
                    "size" : 14.0
                },
                ...
            }            
        },
        ...
    }
}
```

Creating your own theme is easy:

```objective-c
@import OriginateUI;

@interface AppTheme : OriginateTheme

@end

@implementation AppTheme

- (instancetype)init
{
    NSURL *themeURL = [[NSBundle mainBundle] URLForResource:@"Theme" withExtension:@"json"];
    self = [super initWithStyleDefinitionFileAtURL:themeURL];
    return self;
}

@end
```

Typically you would now extend your theme to map the generic properties (`primaryColor`, `secondaryColor`,…) to custom - more specific – ones. `primaryColor` carries fairly little information as to where it is supposed to be used, which is why it is reasonable to prepare a more specific interface.

```objective-c
- (UIColor *)linkColor
{
    return self.colors.primaryColor;
}
```

With this, you have an application specific abstraction on top of the  underlying JSON theme file.

# License
OriginateTheme is available under the MIT license. See the LICENSE file for more info.
