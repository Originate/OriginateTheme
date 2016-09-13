//
//  OriginateThemeFonts.m
//  OriginateUI
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OriginateThemeFonts.h"
#import "UIFont+OriginateThemeKeySource.h"

NSString * const OUIFontsDefaultKey = @"default";
NSString * const OUIFontsDefaultBoldKey = @"defaultBold";
NSString * const OUIFontsDefaultItalicKey = @"defaultItalic";
NSString * const OUIFontsDefaultLightKey = @"defaultLight";

@interface OriginateThemeFonts ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

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

- (UIFont *)defaultFont
{
    if (!_defaultFont) {
        _defaultFont = [UIFont fontForKey:OUIFontsDefaultKey
                                   source:self.definition
                                 fallback:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    }
    
    return _defaultFont;
}

- (UIFont *)defaultBoldFont
{
    if (!_defaultBoldFont) {
        _defaultBoldFont = [UIFont fontForKey:OUIFontsDefaultBoldKey
                                       source:self.definition
                                     fallback:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];
    }
    
    return _defaultBoldFont;
}

- (UIFont *)defaultItalicFont
{
    if (!_defaultItalicFont) {
        _defaultItalicFont = [UIFont fontForKey:OUIFontsDefaultItalicKey
                                         source:self.definition
                                       fallback:[UIFont italicSystemFontOfSize:[UIFont systemFontSize]]];
    }
    
    return _defaultItalicFont;
}

- (UIFont *)defaultLightFont
{
    if (!_defaultLightFont) {
        _defaultLightFont = [UIFont fontForKey:OUIFontsDefaultLightKey
                                        source:self.definition
                                      fallback:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    }
    
    return _defaultLightFont;
}

@end
