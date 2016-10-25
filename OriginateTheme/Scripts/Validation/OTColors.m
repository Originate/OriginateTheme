//
//  OTColors.m
//  OriginateTheme
//
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OTColors.h"
#import "UIColor+OTHex.h"
#import "UIColor+OTKeySource.h"
#import "UIFont+OTKeySource.h"

NSString * const OTColorsCaptionKeyPathKey = @"colors.caption";
NSString * const OTColorsErrorKeyPathKey = @"colors.error";
NSString * const OTColorsPrimaryKeyPathKey = @"colors.primary";
NSString * const OTColorsSecondaryKeyPathKey = @"colors.secondary";
NSString * const OTColorsSuccessKeyPathKey = @"colors.success";
NSString * const OTColorsTitleKeyPathKey = @"colors.title";
NSString * const OTColorsWarningKeyPathKey = @"colors.warning";

@interface OTColors ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@property (nonatomic, strong, readwrite) UIColor *captionColor;
@property (nonatomic, strong, readwrite) UIColor *errorColor;
@property (nonatomic, strong, readwrite) UIColor *primaryColor;
@property (nonatomic, strong, readwrite) UIColor *secondaryColor;
@property (nonatomic, strong, readwrite) UIColor *successColor;
@property (nonatomic, strong, readwrite) UIColor *titleColor;
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

- (UIColor *)captionColor
{
    if (!_captionColor) {
        _captionColor = [UIColor colorForKeyPath:OTColorsCaptionKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x545454]];
    }

    return _captionColor;
}

- (UIColor *)errorColor
{
    if (!_errorColor) {
        _errorColor = [UIColor colorForKeyPath:OTColorsErrorKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0xBD2C00]];
    }

    return _errorColor;
}

- (UIColor *)primaryColor
{
    if (!_primaryColor) {
        _primaryColor = [UIColor colorForKeyPath:OTColorsPrimaryKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x70CFFF]];
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

- (UIColor *)titleColor
{
    if (!_titleColor) {
        _titleColor = [UIColor colorForKeyPath:OTColorsTitleKeyPathKey
                                   source:self.definition
                                 fallback:[UIColor ot_hex:0x000000]];
    }

    return _titleColor;
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
