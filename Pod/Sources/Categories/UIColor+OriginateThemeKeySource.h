//
//  UIColor+OriginateThemeKeySource.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import UIKit;

@interface UIColor (OriginateThemeKeySource)

#pragma mark - Methods
+ (UIColor *)colorForKey:(NSString *)key source:(NSDictionary *)definition fallback:(UIColor *)fallback;

@end
