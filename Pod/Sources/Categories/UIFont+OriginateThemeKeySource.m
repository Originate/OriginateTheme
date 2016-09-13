//
//  UIFont+OriginateThemeKeySource.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "UIFont+OriginateThemeKeySource.h"

NSString * const OTHFontNameKey = @"name";
NSString * const OTHFontSizeKey = @"size";

@implementation UIFont (OriginateThemeKeySource)

#pragma mark - UIFont (OriginateThemeKeySource)

+ (UIFont *)fontForKey:(NSString *)key source:(NSDictionary *)definition fallback:(UIFont *)fallback
{
    NSString *name = [definition valueForKeyPath:[NSString stringWithFormat:@"%@.%@", key, OTHFontNameKey]];
    CGFloat size = [[definition valueForKeyPath:[NSString stringWithFormat:@"%@.%@", key, OTHFontSizeKey]] doubleValue];
    
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
