//
//  UIFont+OriginateThemeKeySource.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import UIKit;

@interface UIFont (OriginateThemeKeySource)

#pragma mark - Methods
+ (UIFont *)fontForKey:(NSString *)key source:(NSDictionary *)definition fallback:(UIFont *)fallback;

@end
