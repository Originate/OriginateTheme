//
//  OriginateThemeColors.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import UIKit;

@interface OriginateThemeColors : NSObject

#pragma mark - Properties
@property (nonatomic, strong, readonly) UIColor *errorColor;
@property (nonatomic, strong, readonly) UIColor *primaryColor;
@property (nonatomic, strong, readonly) UIColor *secondaryColor;
@property (nonatomic, strong, readonly) UIColor *successColor;
@property (nonatomic, strong, readonly) UIColor *warningColor;

#pragma mark - Methods
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
