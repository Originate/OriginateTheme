//
//  UIImage+OriginateThemeHex.m
//  OriginateUI
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "UIColor+OriginateThemeHex.h"

@implementation UIColor (OriginateThemeHex)

+ (instancetype)oth_colorWithHexString:(NSString *)hexString
{
    if ([hexString length] != 6) {
        return nil;
    }
    
    NSRegularExpression *redEx = [NSRegularExpression regularExpressionWithPattern:@"[^0-9|a-fA-F]"
                                                                           options:0
                                                                             error:NULL];
    NSUInteger match = [redEx numberOfMatchesInString:hexString
                                              options:NSMatchingReportCompletion
                                                range:NSMakeRange(0, [hexString length])];
    
    if (match != 0) {
        return nil;
    }
    
    NSRange redRange = NSMakeRange(0, 2);
    NSRange greenRange = NSMakeRange(2, 2);
    NSRange blueRange = NSMakeRange(4, 2);
    
    NSString *redString = [hexString substringWithRange:redRange];
    NSString *greenString = [hexString substringWithRange:greenRange];
    NSString *blueString = [hexString substringWithRange:blueRange];
    
    NSScanner *redScanner = [NSScanner scannerWithString:redString];
    NSScanner *greenScanner = [NSScanner scannerWithString:greenString];
    NSScanner *blueScanner = [NSScanner scannerWithString:blueString];
    
    u_int redValue = 0;
    u_int greenValue = 0;
    u_int blueValue = 0;
    
    [redScanner scanHexInt:&redValue];
    [greenScanner scanHexInt:&greenValue];
    [blueScanner scanHexInt:&blueValue];
    
    CGFloat red = (CGFloat)redValue / 254.0;
    CGFloat green = (CGFloat)greenValue / 254.0;
    CGFloat blue = (CGFloat)blueValue / 254.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (NSString *)oth_hexStringWithColor:(UIColor *)color
{
    if (!color) {
        return nil;
    }
    
    if (color == [UIColor whiteColor]) {
        return @"FFFFFF";
    }
    
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    CGFloat red255 = red * 255.0;
    CGFloat green255 = green * 255.0;
    CGFloat blue255 = blue * 255.0;
    
    NSString *returnString = [NSString stringWithFormat:@"%02x%02x%02x", (unsigned int)red255, (unsigned int)green255, (unsigned int)blue255];
    
    return [returnString uppercaseString];
}

+ (UIColor *)oth_hex:(NSInteger)hexColor
{
    return [[self class] oth_hex:hexColor alpha:1.0];
}

+ (UIColor *)oth_hex:(NSInteger)hexColor alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((CGFloat)((hexColor & 0xFF0000) >> 16)) / 255.0
                           green:((CGFloat)((hexColor & 0xFF00) >> 8)) / 255.0
                            blue:((CGFloat)(hexColor & 0xFF)) / 255.0
                           alpha:alpha];
}

@end
