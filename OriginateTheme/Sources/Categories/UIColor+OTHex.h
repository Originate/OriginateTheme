//
//  UIImage+OTHex.h
//  OriginateTheme
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import UIKit;

@interface UIColor (OTHex)

#pragma mark - Methods
+ (instancetype)ot_colorWithHexString:(NSString *)hexString;
+ (instancetype)ot_hex:(NSInteger)hexColor;
+ (instancetype)ot_hex:(NSInteger)hexColor alpha:(CGFloat)alpha;

+ (NSString *)ot_hexStringWithColor:(UIColor *)color;

@end
