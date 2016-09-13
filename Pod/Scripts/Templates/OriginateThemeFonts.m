//
//  OriginateThemeFonts.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OriginateThemeFonts.h"
#import "UIFont+OriginateThemeKeySource.h"

$OriginateThemeFontsPublicPropertiesKeyPathKeys

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

#pragma mark - OriginateThemeFonts (Properties)
$OriginateThemeFontsPublicPropertiesGetters

@end
