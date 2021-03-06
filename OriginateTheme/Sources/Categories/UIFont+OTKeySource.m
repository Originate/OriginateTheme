//
//  UIFont+OTKeySource.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "UIFont+OTKeySource.h"

NSString * const OTFontNameKey = @"name";
NSString * const OTFontSizeKey = @"size";

@implementation UIFont (OTKeySource)

#pragma mark - UIFont (OTKeySource)

+ (UIFont *)fontForKeyPath:(NSString *)keyPath source:(NSDictionary *)definition fallback:(UIFont *)fallback
{
    NSString *name = [definition valueForKeyPath:[NSString stringWithFormat:@"%@.%@", keyPath, OTFontNameKey]];
    CGFloat size = [[definition valueForKeyPath:[NSString stringWithFormat:@"%@.%@", keyPath, OTFontSizeKey]] doubleValue];
    
    if (size == 0.0) {
        size = [UIFont systemFontSize];
    }
    
    if (!name && fallback) {
        return fallback;
    } else if (!name) {
        return [UIFont systemFontOfSize:size];
    }
    
    return [UIFont fontWithName:name size:size];
}

@end
