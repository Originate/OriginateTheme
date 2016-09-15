//
//  OriginateThemeFonts.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate Inc. All rights reserved.
//

#import "OriginateThemeFonts.h"
#import "UIColor+OriginateThemeHex.h";
#import "UIColor+OriginateThemeKeySource.h";
#import "UIFont+OriginateThemeKeySource.h"

NSString * const OTHFontsDefaultKeyPathKey = @"fonts.default";
NSString * const OTHFontsDefaultBoldKeyPathKey = @"fonts.defaultBold";
NSString * const OTHFontsDefaultItalicKeyPathKey = @"fonts.defaultItalic";
NSString * const OTHFontsDefaultLightKeyPathKey = @"fonts.defaultLight";

@interface OriginateThemeFonts ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@property (nonatomic, strong, readwrite) UIFont *defaultFont;
@property (nonatomic, strong, readwrite) UIFont *defaultBoldFont;
@property (nonatomic, strong, readwrite) UIFont *defaultItalicFont;
@property (nonatomic, strong, readwrite) UIFont *defaultLightFont;

@end

@implementation OriginateThemeFonts

#pragma mark - OriginateThemeFonts

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self) {
        _definition = dictionary;
    }

    return self;
}

#pragma mark - OriginateThemeFonts (Properties)

- (UIFont *)defaultFont
{
    if (!_defaultFont) {
        _defaultFont = [UIFont fontForKeyPath:OTHFontsDefaultKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
    }

    return _defaultFont;
}

- (UIFont *)defaultBoldFont
{
    if (!_defaultBoldFont) {
        _defaultBoldFont = [UIFont fontForKeyPath:OTHFontsDefaultBoldKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0]];
    }

    return _defaultBoldFont;
}

- (UIFont *)defaultItalicFont
{
    if (!_defaultItalicFont) {
        _defaultItalicFont = [UIFont fontForKeyPath:OTHFontsDefaultItalicKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Thin" size:14.0]];
    }

    return _defaultItalicFont;
}

- (UIFont *)defaultLightFont
{
    if (!_defaultLightFont) {
        _defaultLightFont = [UIFont fontForKeyPath:OTHFontsDefaultLightKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];
    }

    return _defaultLightFont;
}

@end
