//
//  OriginateThemeComponents.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OriginateThemeComponents.h"
#import "UIColor+OriginateThemeKeySource.h"
#import "UIFont+OriginateThemeKeySource.h"

$OriginateThemeComponentsPropertiesKeyPathKeys

@interface OriginateThemeComponents ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

$OriginateThemeComponentsPrivateProperties

@end

@implementation OriginateThemeComponents

#pragma mark - OriginateThemeComponents

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self) {
        _definition = dictionary;
    }

    return self;
}

#pragma mark - OriginateThemeComponents (Properties)
$OriginateThemeComponentsPropertiesGetters

@end
