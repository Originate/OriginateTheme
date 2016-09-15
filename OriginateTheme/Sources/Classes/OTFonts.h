//
//  OTFonts.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-13.
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import UIKit;

@interface OTFonts : NSObject

#pragma mark - Properties
@property (nonatomic, strong, readonly) UIFont *defaultFont;
@property (nonatomic, strong, readonly) UIFont *defaultBoldFont;
@property (nonatomic, strong, readonly) UIFont *defaultItalicFont;
@property (nonatomic, strong, readonly) UIFont *defaultLightFont;

#pragma mark - Methods
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
