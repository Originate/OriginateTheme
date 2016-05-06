//
//  MyTheme.h
//  OriginateUI
//
//  Created by Philip Kluz on 9/22/15.
//  Copyright © 2015 originate.com. All rights reserved.
//

@import UIKit;
@import OriginateTheme;

@interface MyTheme : OriginateTheme

#pragma mark - Properties
@property (nonatomic, strong, readonly) UIColor *rootViewBackgroundColor;
@property (nonatomic, strong, readonly) UIColor *navigationBarBackgroundColor;
@property (nonatomic, strong, readonly) UIColor *navigationBarTextColor;

@end
