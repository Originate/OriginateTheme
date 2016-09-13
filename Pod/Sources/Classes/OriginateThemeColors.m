//
//  OriginateThemeColors.m
//  OriginateUI
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OriginateThemeColors.h"

NSString * const OUIColorPrimaryKey = @"primary";
NSString * const OUIColorSecondaryKey = @"secondary";
NSString * const OUIColorSuccessKey = @"success";
NSString * const OUIColorWarningKey = @"warning";
NSString * const OUIColorErrorKey = @"error";

@interface OriginateThemeColors ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@end

@implementation OriginateThemeColors

#pragma mark - OriginateThemeColors

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        _definition = dictionary;
    }
    
    return self;
}

- (UIColor *)primaryColor
{
    if (!_primaryColor) {
        _primaryColor = [[OriginateThemeColors class] colorForKey:OUIColorPrimaryKey
                                                           source:self.definition
                                                         fallback:[UIColor oth_hex:0x00A0D8]];
    }
    
    return _primaryColor;
}

- (UIColor *)secondaryColor
{
    if (!_secondaryColor) {
        _secondaryColor = [[OriginateThemeColors class] colorForKey:OUIColorSecondaryKey
                                                             source:self.definition
                                                           fallback:[UIColor oth_hex:0xFCD92B]];
    }
    
    return _secondaryColor;
}

- (UIColor *)successColor
{
    if (!_successColor) {
        _successColor = [[OriginateThemeColors class] colorForKey:OUIColorSuccessKey
                                                           source:self.definition
                                                         fallback:[UIColor oth_hex:0x95BE22]];
    }
    
    return _successColor;
}

- (UIColor *)warningColor
{
    if (!_warningColor) {
        _warningColor = [[OriginateThemeColors class] colorForKey:OUIColorWarningKey
                                                           source:self.definition
                                                         fallback:[UIColor oth_hex:0xFFA500]];
    }
    
    return _warningColor;
}

- (UIColor *)errorColor
{
    if (!_errorColor) {
        _errorColor = [[OriginateThemeColors class] colorForKey:OUIColorErrorKey
                                                         source:self.definition
                                                       fallback:[UIColor oth_hex:0xFD1111]];
    }
    
    return _errorColor;
}

+ (UIColor *)colorForKey:(NSString *)key
                  source:(NSDictionary *)definition
                fallback:(UIColor *)fallback
{
    NSString *colorValue = definition[key];
    
    if ([colorValue length] == 0) {
        return fallback;
    }
    
    UIColor *color = [UIColor oth_colorWithHexString:colorValue];
    
    return color ?: fallback;
}

@end
