//
//  OTThemeable.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-15.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import Foundation;

@class OTTheme;

@protocol OTThemeable <NSObject>

#pragma mark - Methods
@required
- (void)setTheme:(OTTheme *)theme;

@end
