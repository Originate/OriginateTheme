//
//  OriginateThemeComponents.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OriginateThemeComponents.h"
#import "UIColor+OriginateThemeHex.h";
#import "UIColor+OriginateThemeKeySource.h";
#import "UIFont+OriginateThemeKeySource.h"

NSString * const OTHComponentsNavigationBarColorsBackgroundKeyPathKey = @"components.navigationBar.colors.background";
NSString * const OTHComponentsNavigationBarColorsDescriptionKeyPathKey = @"components.navigationBar.colors.description";
NSString * const OTHComponentsNavigationBarColorsTitleKeyPathKey = @"components.navigationBar.colors.title";
NSString * const OTHComponentsNavigationBarFontsDescriptionKeyPathKey = @"components.navigationBar.fonts.description";
NSString * const OTHComponentsNavigationBarFontsTextKeyPathKey = @"components.navigationBar.fonts.text";

NSString * const OTHComponentsTabBarColorsBackgroundKeyPathKey = @"components.tabBar.colors.background";
NSString * const OTHComponentsTabBarColorsSelectedTextKeyPathKey = @"components.tabBar.colors.selectedText";
NSString * const OTHComponentsTabBarColorsTextKeyPathKey = @"components.tabBar.colors.text";
NSString * const OTHComponentsTabBarFontsTitleKeyPathKey = @"components.tabBar.fonts.title";

@interface OriginateThemeComponents ()

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

@implementation OriginateThemeComponents

#pragma mark - OriginateThemeComponents

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self) {
        _definition = dictionary;
    }

    return self;
}

#pragma mark - OriginateThemeComponents (Properties)

- (UIColor *)navigationBarBackgroundColor
{
    if (!_navigationBarBackgroundColor) {
        _navigationBarBackgroundColor = [UIColor colorForKeyPath:OTHComponentsNavigationBarColorsBackgroundKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0x84E0FA]];
    }

    return _navigationBarBackgroundColor;
}

- (UIColor *)navigationBarDescriptionColor
{
    if (!_navigationBarDescriptionColor) {
        _navigationBarDescriptionColor = [UIColor colorForKeyPath:OTHComponentsNavigationBarColorsDescriptionKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0x979797]];
    }

    return _navigationBarDescriptionColor;
}

- (UIColor *)navigationBarTitleColor
{
    if (!_navigationBarTitleColor) {
        _navigationBarTitleColor = [UIColor colorForKeyPath:OTHComponentsNavigationBarColorsTitleKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0x000000]];
    }

    return _navigationBarTitleColor;
}

- (UIFont *)navigationBarDescriptionFont
{
    if (!_navigationBarDescriptionFont) {
        _navigationBarDescriptionFont = [UIFont fontForKeyPath:OTHComponentsNavigationBarFontsDescriptionKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]];
    }

    return _navigationBarDescriptionFont;
}

- (UIFont *)navigationBarTextFont
{
    if (!_navigationBarTextFont) {
        _navigationBarTextFont = [UIFont fontForKeyPath:OTHComponentsNavigationBarFontsTextKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];
    }

    return _navigationBarTextFont;
}

- (UIColor *)tabBarBackgroundColor
{
    if (!_tabBarBackgroundColor) {
        _tabBarBackgroundColor = [UIColor colorForKeyPath:OTHComponentsTabBarColorsBackgroundKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0xFFFFFF]];
    }

    return _tabBarBackgroundColor;
}

- (UIColor *)tabBarSelectedTextColor
{
    if (!_tabBarSelectedTextColor) {
        _tabBarSelectedTextColor = [UIColor colorForKeyPath:OTHComponentsTabBarColorsSelectedTextKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0x4C66A4]];
    }

    return _tabBarSelectedTextColor;
}

- (UIColor *)tabBarTextColor
{
    if (!_tabBarTextColor) {
        _tabBarTextColor = [UIColor colorForKeyPath:OTHComponentsTabBarColorsTextKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0x424242]];
    }

    return _tabBarTextColor;
}

- (UIFont *)tabBarTitleFont
{
    if (!_tabBarTitleFont) {
        _tabBarTitleFont = [UIFont fontForKeyPath:OTHComponentsTabBarFontsTitleKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];
    }

    return _tabBarTitleFont;
}

@end
