//
//  UIImage+OriginateThemeHex.h
//  OriginateUI
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import UIKit;

@interface UIColor (OriginateThemeHex)

#pragma mark - Methods
+ (instancetype)oth_colorWithHexString:(NSString *)hexString;
+ (NSString *)oth_hexStringWithColor:(UIColor *)color;

+ (instancetype)oth_hex:(NSInteger)hexColor;
+ (instancetype)oth_hex:(NSInteger)hexColor alpha:(CGFloat)alpha;

@end
