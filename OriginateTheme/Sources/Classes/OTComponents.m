//
//  OTComponents.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OTComponents.h"
#import "UIColor+OTHex.h"
#import "UIColor+OTKeySource.h"
#import "UIFont+OTKeySource.h"

NSString * const OTComponentsNavigationBarColorsBackgroundKeyPathKey = @"components.navigationBar.colors.background";
NSString * const OTComponentsNavigationBarColorsDescriptionKeyPathKey = @"components.navigationBar.colors.description";
NSString * const OTComponentsNavigationBarColorsTitleKeyPathKey = @"components.navigationBar.colors.title";
NSString * const OTComponentsNavigationBarFontsDescriptionKeyPathKey = @"components.navigationBar.fonts.description";
NSString * const OTComponentsNavigationBarFontsTextKeyPathKey = @"components.navigationBar.fonts.text";

NSString * const OTComponentsTabBarColorsBackgroundKeyPathKey = @"components.tabBar.colors.background";
NSString * const OTComponentsTabBarColorsSelectedTextKeyPathKey = @"components.tabBar.colors.selectedText";
NSString * const OTComponentsTabBarColorsTextKeyPathKey = @"components.tabBar.colors.text";
NSString * const OTComponentsTabBarFontsTitleKeyPathKey = @"components.tabBar.fonts.title";

@interface OTComponents ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@property (nonatomic, strong, readwrite) UIColor *navigationBarBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *navigationBarDescriptionColor;
@property (nonatomic, strong, readwrite) UIColor *navigationBarTitleColor;
@property (nonatomic, strong, readwrite) UIFont *navigationBarDescriptionFont;
@property (nonatomic, strong, readwrite) UIFont *navigationBarTextFont;

@property (nonatomic, strong, readwrite) UIColor *tabBarBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *tabBarSelectedTextColor;
@property (nonatomic, strong, readwrite) UIColor *tabBarTextColor;
@property (nonatomic, strong, readwrite) UIFont *tabBarTitleFont;

@end

@implementation OTComponents

#pragma mark - OTComponents

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self) {
        _definition = dictionary;
    }

    return self;
}

#pragma mark - OTComponents (Properties)

- (UIColor *)navigationBarBackgroundColor
{
    if (!_navigationBarBackgroundColor) {
        _navigationBarBackgroundColor = [UIColor colorForKeyPath:OTComponentsNavigationBarColorsBackgroundKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x84E0FA]];
    }

    return _navigationBarBackgroundColor;
}

- (UIColor *)navigationBarDescriptionColor
{
    if (!_navigationBarDescriptionColor) {
        _navigationBarDescriptionColor = [UIColor colorForKeyPath:OTComponentsNavigationBarColorsDescriptionKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x979797]];
    }

    return _navigationBarDescriptionColor;
}

- (UIColor *)navigationBarTitleColor
{
    if (!_navigationBarTitleColor) {
        _navigationBarTitleColor = [UIColor colorForKeyPath:OTComponentsNavigationBarColorsTitleKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x000000]];
    }

    return _navigationBarTitleColor;
}

- (UIFont *)navigationBarDescriptionFont
{
    if (!_navigationBarDescriptionFont) {
        _navigationBarDescriptionFont = [UIFont fontForKeyPath:OTComponentsNavigationBarFontsDescriptionKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]];
    }

    return _navigationBarDescriptionFont;
}

- (UIFont *)navigationBarTextFont
{
    if (!_navigationBarTextFont) {
        _navigationBarTextFont = [UIFont fontForKeyPath:OTComponentsNavigationBarFontsTextKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];
    }

    return _navigationBarTextFont;
}

- (UIColor *)tabBarBackgroundColor
{
    if (!_tabBarBackgroundColor) {
        _tabBarBackgroundColor = [UIColor colorForKeyPath:OTComponentsTabBarColorsBackgroundKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0xFFFFFF]];
    }

    return _tabBarBackgroundColor;
}

- (UIColor *)tabBarSelectedTextColor
{
    if (!_tabBarSelectedTextColor) {
        _tabBarSelectedTextColor = [UIColor colorForKeyPath:OTComponentsTabBarColorsSelectedTextKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x4C66A4]];
    }

    return _tabBarSelectedTextColor;
}

- (UIColor *)tabBarTextColor
{
    if (!_tabBarTextColor) {
        _tabBarTextColor = [UIColor colorForKeyPath:OTComponentsTabBarColorsTextKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x424242]];
    }

    return _tabBarTextColor;
}

- (UIFont *)tabBarTitleFont
{
    if (!_tabBarTitleFont) {
        _tabBarTitleFont = [UIFont fontForKeyPath:OTComponentsTabBarFontsTitleKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];
    }

    return _tabBarTitleFont;
}

@end
