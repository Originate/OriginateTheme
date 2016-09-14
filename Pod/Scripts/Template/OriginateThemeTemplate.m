//
//  $OriginateThemeClassName.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "$OriginateThemeClassName.h"
#import "UIColor+OriginateThemeHex.h";
#import "UIColor+OriginateThemeKeySource.h";
#import "UIFont+OriginateThemeKeySource.h"

$OriginateThemePropertiesKeyPathKeys

@interface $OriginateThemeClassName ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

$OriginateThemePrivateProperties

@end

@implementation $OriginateThemeClassName

#pragma mark - $OriginateThemeClassName

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self) {
        _definition = dictionary;
    }

    return self;
}

#pragma mark - $OriginateThemeClassName (Properties)
$OriginateThemePropertiesGetters

@end
