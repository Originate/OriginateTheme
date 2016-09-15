//
//  OriginateThemeColors.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate Inc. All rights reserved.
//

#import "OriginateThemeColors.h"
#import "UIColor+OriginateThemeHex.h";
#import "UIColor+OriginateThemeKeySource.h";
#import "UIFont+OriginateThemeKeySource.h"

NSString * const OTHColorsErrorKeyPathKey = @"colors.error";
NSString * const OTHColorsPrimaryKeyPathKey = @"colors.primary";
NSString * const OTHColorsSecondaryKeyPathKey = @"colors.secondary";
NSString * const OTHColorsSuccessKeyPathKey = @"colors.success";
NSString * const OTHColorsWarningKeyPathKey = @"colors.warning";

@interface OriginateThemeColors ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@property (nonatomic, strong, readwrite) UIColor *errorColor;
@property (nonatomic, strong, readwrite) UIColor *primaryColor;
@property (nonatomic, strong, readwrite) UIColor *secondaryColor;
@property (nonatomic, strong, readwrite) UIColor *successColor;
@property (nonatomic, strong, readwrite) UIColor *warningColor;

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

#pragma mark - OriginateThemeColors (Properties)

- (UIColor *)errorColor
{
    if (!_errorColor) {
        _errorColor = [UIColor colorForKeyPath:OTHColorsErrorKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0xbd2c00]];
    }

    return _errorColor;
}

- (UIColor *)primaryColor
{
    if (!_primaryColor) {
        _primaryColor = [UIColor colorForKeyPath:OTHColorsPrimaryKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0x00A0D8]];
    }

    return _primaryColor;
}

- (UIColor *)secondaryColor
{
    if (!_secondaryColor) {
        _secondaryColor = [UIColor colorForKeyPath:OTHColorsSecondaryKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0xFCD92B]];
    }

    return _secondaryColor;
}

- (UIColor *)successColor
{
    if (!_successColor) {
        _successColor = [UIColor colorForKeyPath:OTHColorsSuccessKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0x95BE22]];
    }

    return _successColor;
}

- (UIColor *)warningColor
{
    if (!_warningColor) {
        _warningColor = [UIColor colorForKeyPath:OTHColorsWarningKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor oth_hex:0xFFA500]];
    }

    return _warningColor;
}

@end
