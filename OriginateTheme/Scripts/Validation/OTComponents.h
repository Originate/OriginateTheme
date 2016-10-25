//
//  OTComponents.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import UIKit;

@interface OTComponents : NSObject

#pragma mark - Properties
@property (nonatomic, strong, readonly) UIColor *navigationBarBackgroundColor;
@property (nonatomic, strong, readonly) UIColor *navigationBarTintColor;
@property (nonatomic, strong, readonly) UIFont *navigationBarDescriptionFont;
@property (nonatomic, strong, readonly) UIFont *navigationBarTextFont;

@property (nonatomic, strong, readonly) UIColor *tabBarBackgroundColor;
@property (nonatomic, strong, readonly) UIColor *tabBarTintColor;
@property (nonatomic, strong, readonly) UIFont *tabBarTextFont;

#pragma mark - Methods
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
