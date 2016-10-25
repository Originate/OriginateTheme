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
NSString * const OTComponentsNavigationBarColorsTintKeyPathKey = @"components.navigationBar.colors.tint";
NSString * const OTComponentsNavigationBarFontsDescriptionKeyPathKey = @"components.navigationBar.fonts.description";
NSString * const OTComponentsNavigationBarFontsTextKeyPathKey = @"components.navigationBar.fonts.text";

NSString * const OTComponentsTabBarColorsBackgroundKeyPathKey = @"components.tabBar.colors.background";
NSString * const OTComponentsTabBarColorsTintKeyPathKey = @"components.tabBar.colors.tint";
NSString * const OTComponentsTabBarFontsTextKeyPathKey = @"components.tabBar.fonts.text";

@interface OTComponents ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@property (nonatomic, strong, readwrite) UIColor *navigationBarBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *navigationBarTintColor;
@property (nonatomic, strong, readwrite) UIFont *navigationBarDescriptionFont;
@property (nonatomic, strong, readwrite) UIFont *navigationBarTextFont;

@property (nonatomic, strong, readwrite) UIColor *tabBarBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *tabBarTintColor;
@property (nonatomic, strong, readwrite) UIFont *tabBarTextFont;

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

- (UIColor *)navigationBarTintColor
{
    if (!_navigationBarTintColor) {
        _navigationBarTintColor = [UIColor colorForKeyPath:OTComponentsNavigationBarColorsTintKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x979797]];
    }

    return _navigationBarTintColor;
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

- (UIColor *)tabBarTintColor
{
    if (!_tabBarTintColor) {
        _tabBarTintColor = [UIColor colorForKeyPath:OTComponentsTabBarColorsTintKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0xFF9600]];
    }

    return _tabBarTintColor;
}

- (UIFont *)tabBarTextFont
{
    if (!_tabBarTextFont) {
        _tabBarTextFont = [UIFont fontForKeyPath:OTComponentsTabBarFontsTextKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];
    }

    return _tabBarTextFont;
}

@end
