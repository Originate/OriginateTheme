//
//  UIFont+OTKeySource.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import UIKit;

@interface UIFont (OTKeySource)

#pragma mark - Methods
+ (UIFont *)fontForKeyPath:(NSString *)keyPath source:(NSDictionary *)definition fallback:(UIFont *)fallback;

@end
