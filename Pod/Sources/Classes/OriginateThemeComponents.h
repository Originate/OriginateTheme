//
//  OriginateThemeComponents.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import UIKit;

@interface OriginateThemeComponents : NSObject

#pragma mark - Properties
@property (nonatomic, strong, readonly) UIColor *navigationBarBackgroundColor;
@property (nonatomic, strong, readonly) UIColor *navigationBarDescriptionColor;
@property (nonatomic, strong, readonly) UIColor *navigationBarTitleColor;
@property (nonatomic, strong, readonly) UIFont *navigationBarDescriptionFont;
@property (nonatomic, strong, readonly) UIFont *navigationBarTextFont;

@property (nonatomic, strong, readonly) UIColor *tabBarBackgroundColor;
@property (nonatomic, strong, readonly) UIColor *tabBarSelectedTextColor;
@property (nonatomic, strong, readonly) UIColor *tabBarTextColor;
@property (nonatomic, strong, readonly) UIFont *tabBarTitleFont;

#pragma mark - Methods
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
