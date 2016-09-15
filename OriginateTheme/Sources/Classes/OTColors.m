//
//  OTColors.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OTColors.h"
#import "UIColor+OTHex.h"
#import "UIColor+OTKeySource.h"
#import "UIFont+OTKeySource.h"

NSString * const OTColorsErrorKeyPathKey = @"colors.error";
NSString * const OTColorsPrimaryKeyPathKey = @"colors.primary";
NSString * const OTColorsSecondaryKeyPathKey = @"colors.secondary";
NSString * const OTColorsSuccessKeyPathKey = @"colors.success";
NSString * const OTColorsWarningKeyPathKey = @"colors.warning";

@interface OTColors ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@property (nonatomic, strong, readwrite) UIColor *errorColor;
@property (nonatomic, strong, readwrite) UIColor *primaryColor;
@property (nonatomic, strong, readwrite) UIColor *secondaryColor;
@property (nonatomic, strong, readwrite) UIColor *successColor;
@property (nonatomic, strong, readwrite) UIColor *warningColor;

@end

@implementation OTColors

#pragma mark - OTColors

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self) {
        _definition = dictionary;
    }

    return self;
}

#pragma mark - OTColors (Properties)

- (UIColor *)errorColor
{
    if (!_errorColor) {
        _errorColor = [UIColor colorForKeyPath:OTColorsErrorKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0xbd2c00]];
    }

    return _errorColor;
}

- (UIColor *)primaryColor
{
    if (!_primaryColor) {
        _primaryColor = [UIColor colorForKeyPath:OTColorsPrimaryKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x00A0D8]];
    }

    return _primaryColor;
}

- (UIColor *)secondaryColor
{
    if (!_secondaryColor) {
        _secondaryColor = [UIColor colorForKeyPath:OTColorsSecondaryKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0xFCD92B]];
    }

    return _secondaryColor;
}

- (UIColor *)successColor
{
    if (!_successColor) {
        _successColor = [UIColor colorForKeyPath:OTColorsSuccessKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x95BE22]];
    }

    return _successColor;
}

- (UIColor *)warningColor
{
    if (!_warningColor) {
        _warningColor = [UIColor colorForKeyPath:OTColorsWarningKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0xFFA500]];
    }

    return _warningColor;
}

@end
