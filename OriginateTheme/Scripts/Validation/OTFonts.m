//
//  OTFonts.m
//  OriginateTheme
//
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OTFonts.h"
#import "UIColor+OTHex.h"
#import "UIColor+OTKeySource.h"
#import "UIFont+OTKeySource.h"

NSString * const OTFontsDefaultKeyPathKey = @"fonts.default";
NSString * const OTFontsDefaultBoldKeyPathKey = @"fonts.defaultBold";
NSString * const OTFontsDefaultItalicKeyPathKey = @"fonts.defaultItalic";
NSString * const OTFontsDefaultLightKeyPathKey = @"fonts.defaultLight";

@interface OTFonts ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@property (nonatomic, strong, readwrite) UIFont *defaultFont;
@property (nonatomic, strong, readwrite) UIFont *defaultBoldFont;
@property (nonatomic, strong, readwrite) UIFont *defaultItalicFont;
@property (nonatomic, strong, readwrite) UIFont *defaultLightFont;

@end

@implementation OTFonts

#pragma mark - OTFonts

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self) {
        _definition = dictionary;
    }

    return self;
}

#pragma mark - OTFonts (Properties)

- (UIFont *)defaultFont
{
    if (!_defaultFont) {
        _defaultFont = [UIFont fontForKeyPath:OTFontsDefaultKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue" size:22.0]];
    }

    return _defaultFont;
}

- (UIFont *)defaultBoldFont
{
    if (!_defaultBoldFont) {
        _defaultBoldFont = [UIFont fontForKeyPath:OTFontsDefaultBoldKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0]];
    }

    return _defaultBoldFont;
}

- (UIFont *)defaultItalicFont
{
    if (!_defaultItalicFont) {
        _defaultItalicFont = [UIFont fontForKeyPath:OTFontsDefaultItalicKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Thin" size:14.0]];
    }

    return _defaultItalicFont;
}

- (UIFont *)defaultLightFont
{
    if (!_defaultLightFont) {
        _defaultLightFont = [UIFont fontForKeyPath:OTFontsDefaultLightKeyPathKey
                                 source:self.definition
                               fallback:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]];
    }

    return _defaultLightFont;
}

@end
