//
//  UIImage+OTHex.m
//  OriginateTheme
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "UIColor+OTHex.h"

@implementation UIColor (OTHex)

#pragma mark - UIColor (OTHex)

+ (instancetype)ot_colorWithHexString:(NSString *)hexString
{
    if ([hexString length] == 6) {
        hexString = [NSString stringWithFormat:@"%@FF", [hexString uppercaseString]];
    }
    
    if ([hexString length] != 8) {
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
    NSRange alphaRange = NSMakeRange(6, 2);
    
    NSString *redString = [hexString substringWithRange:redRange];
    NSString *greenString = [hexString substringWithRange:greenRange];
    NSString *blueString = [hexString substringWithRange:blueRange];
    NSString *alphaString = [hexString substringWithRange:alphaRange];
    
    NSScanner *redScanner = [NSScanner scannerWithString:redString];
    NSScanner *greenScanner = [NSScanner scannerWithString:greenString];
    NSScanner *blueScanner = [NSScanner scannerWithString:blueString];
    NSScanner *alphaScanner = [NSScanner scannerWithString:alphaString];
    
    u_int redValue = 0;
    u_int greenValue = 0;
    u_int blueValue = 0;
    u_int alphaValue = 0;
    
    [redScanner scanHexInt:&redValue];
    [greenScanner scanHexInt:&greenValue];
    [blueScanner scanHexInt:&blueValue];
    [alphaScanner scanHexInt:&alphaValue];
    
    CGFloat red = (CGFloat)redValue / 255.0;
    CGFloat green = (CGFloat)greenValue / 255.0;
    CGFloat blue = (CGFloat)blueValue / 255.0;
    CGFloat alpha = (CGFloat)alphaValue / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)ot_hex:(NSInteger)hexColor
{
    return [UIColor colorWithRed:((CGFloat)((hexColor & 0xFF000000) >> 24)) / 255.0
                           green:((CGFloat)((hexColor & 0xFF0000) >> 16)) / 255.0
                            blue:((CGFloat)((hexColor & 0xFF00) >> 8)) / 255.0
                           alpha:((CGFloat)(hexColor & 0xFF) / 255.0];
}

+ (NSString *)ot_hexStringWithColor:(UIColor *)color
{
    if (!color) {
        return nil;
    }
    
    if (color == [UIColor whiteColor]) {
        return @"FFFFFFFF";
    }
    
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    CGFloat red255 = red * 255.0;
    CGFloat green255 = green * 255.0;
    CGFloat blue255 = blue * 255.0;
    CGFloat alpha255 = alpha * 255.0;
    
    NSString *returnString =
        [NSString stringWithFormat:@"%02x%02x%02x%02x", (unsigned int)red255, (unsigned int)green255, (unsigned int)blue255, (unsigned int)alpha255];
    
    return [returnString uppercaseString];
}

@end
