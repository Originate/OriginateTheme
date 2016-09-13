//
//  OriginateThemeable.h
//  OriginateTheme
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import Foundation;

@class OriginateTheme;

@protocol OriginateThemeable <NSObject>

#pragma mark - Methods
@required
- (void)setTheme:(OriginateTheme *)theme;

@end
