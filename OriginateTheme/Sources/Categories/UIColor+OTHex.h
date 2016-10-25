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
+ (NSString *)ot_hexStringWithColor:(UIColor *)color;

@end
