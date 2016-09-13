//
//  UIColor+OriginateThemeKeySource.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "UIColor+OriginateThemeKeySource.h"
#import "UIColor+OriginateThemeHex.h"

@implementation UIColor (OriginateThemeKeySource)

#pragma mark - UIColor (OriginateThemeKeySource)

+ (UIColor *)colorForKeyPath:(NSString *)keyPath source:(NSDictionary *)definition fallback:(UIColor *)fallback
{
    NSString *colorValue = [definition valueForKeyPath:keyPath];
    
    if ([colorValue length] == 0) {
        return fallback;
    }
    
    UIColor *color = [UIColor oth_colorWithHexString:colorValue];
    
    return color ?: fallback;
}

@end
