//
//  UIColor+OTKeySource.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "UIColor+OTKeySource.h"
#import "UIColor+OTHex.h"

@implementation UIColor (OTKeySource)

#pragma mark - UIColor (OriginateThemeKeySource)

+ (UIColor *)colorForKeyPath:(NSString *)keyPath source:(NSDictionary *)definition fallback:(UIColor *)fallback
{
    NSString *colorValue = [definition valueForKeyPath:keyPath];
    
    if ([colorValue length] == 0) {
        return fallback;
    }
    
    UIColor *color = [UIColor ot_colorWithHexString:colorValue];
    
    return color ?: fallback;
}

@end
