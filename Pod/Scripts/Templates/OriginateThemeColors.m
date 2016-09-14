//
//  OriginateThemeColors.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OriginateThemeColors.h"
#import "UIColor+OriginateThemeHex.h"
#import "UIColor+OriginateThemeKeySource.h"

$OriginateThemeColorsPropertiesKeyPathKeys

@interface OriginateThemeColors ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

$OriginateThemeColorsPrivateProperties

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

#pragma mark - OriginateThemeColor (Properties)
$OriginateThemeColorsPropertiesGetters

@end
