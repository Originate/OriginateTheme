//
//  OriginateThemeFonts.m
//  OriginateUI
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OriginateThemeFonts.h"

NSString * const OUIFontsDefaultKey = @"default";
NSString * const OUIFontsDefaultBoldKey = @"defaultBold";
NSString * const OUIFontsDefaultItalicKey = @"defaultItalic";
NSString * const OUIFontsDefaultLightKey = @"defaultLight";

NSString * const OUIFontNameKey = @"name";
NSString * const OUIFontSizeKey = @"size";

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
        _defaultFont = [[self class] fontForKey:OUIFontsDefaultKey
                                         source:self.definition
                                       fallback:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    }
    
    return _defaultFont;
}

- (UIFont *)defaultBoldFont
{
    if (!_defaultBoldFont) {
        _defaultBoldFont = [[self class] fontForKey:OUIFontsDefaultBoldKey
                                             source:self.definition
                                           fallback:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];
    }
    
    return _defaultBoldFont;
}

- (UIFont *)defaultItalicFont
{
    if (!_defaultItalicFont) {
        _defaultItalicFont = [[self class] fontForKey:OUIFontsDefaultItalicKey
                                               source:self.definition
                                             fallback:[UIFont italicSystemFontOfSize:[UIFont systemFontSize]]];
    }
    
    return _defaultItalicFont;
}

- (UIFont *)defaultLightFont
{
    if (!_defaultLightFont) {
        _defaultLightFont = [[self class] fontForKey:OUIFontsDefaultLightKey
                                              source:self.definition
                                            fallback:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    }
    
    return _defaultLightFont;
}

+ (UIFont *)fontForKey:(NSString *)key
                source:(NSDictionary *)definition
              fallback:(UIFont *)fallback
{
    NSString *name = definition[key][OUIFontNameKey];
    CGFloat size = [definition[key][OUIFontSizeKey] doubleValue];
    
    if (size == 0.0) {
        size = [UIFont systemFontSize];
    }
    
    if (!name && fallback) {
        return fallback;
    }
    else if (!name) {
        return [UIFont systemFontOfSize:size];
    }
    
    return [UIFont fontWithName:name size:size];
}

@end
