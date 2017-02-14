//
//  OTFonts.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OTFonts.h"
#import "UIColor+OTHex.h"
#import "UIColor+OTKeySource.h"
#import "UIFont+OTKeySource.h"

@interface OTFonts ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@end

@implementation OTFonts

#pragma mark - OTFonts

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self) {
        _definition = dictionary;
    }

    return self;
}

@end
