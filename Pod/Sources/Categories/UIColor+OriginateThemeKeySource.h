//
//  UIColor+OriginateThemeKeySource.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import UIKit;

@interface UIColor (OriginateThemeKeySource)

#pragma mark - Methods
+ (UIColor *)colorForKeyPath:(NSString *)keyPath source:(NSDictionary *)definition fallback:(UIColor *)fallback;

@end
