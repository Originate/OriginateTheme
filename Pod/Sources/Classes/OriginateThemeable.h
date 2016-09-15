//
//  OriginateThemeable.h
//  OriginateTheme
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import Foundation;

@class OriginateTheme;

@protocol OriginateThemeable <NSObject>

#pragma mark - Methods
@required
- (void)setTheme:(OriginateTheme *)theme;

@end
