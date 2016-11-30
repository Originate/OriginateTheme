//
//  OriginateThemeTests.m
//  OriginateThemeTests
//
//  Created by Allen Wu on 2016-11-28.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import XCTest;
#import "UIColor+OTHex.h"

@interface OriginateThemeTests : XCTestCase

@end

@implementation OriginateThemeTests

#pragma mark - UIColor+OTHex

- (void)testHexStringRGB
{
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"000000"], [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"FF0000"], [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"00FF00"], [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"0000FF"], [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"FFFFFF"], [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]);
    
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"#000000"], [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"#FFFFFF"], [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]);
}

- (void)testHexStringRGBA
{
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"00000000"], [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"000000FF"], [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"FFFFFF00"], [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"FFFFFFFF"], [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]);
}

- (void)testHexRGBA
{
    XCTAssertEqualObjects([UIColor ot_hex:0x000000FF], [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]);
    XCTAssertEqualObjects([UIColor ot_hex:0xFF0000FF], [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]);
    XCTAssertEqualObjects([UIColor ot_hex:0x00FF00FF], [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0]);
    XCTAssertEqualObjects([UIColor ot_hex:0x0000FFFF], [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0]);
    XCTAssertEqualObjects([UIColor ot_hex:0xFFFFFFFF], [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]);
}

- (void)testCommonColors
{
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"FF0000"], [UIColor redColor]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"00FF00"], [UIColor greenColor]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"0000FF"], [UIColor blueColor]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"FF00FF"], [UIColor magentaColor]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"FFFF00"], [UIColor yellowColor]);
    XCTAssertEqualObjects([UIColor ot_colorWithHexString:@"00FFFF"], [UIColor cyanColor]);
}

- (void)testInvalidHexStrings
{
    XCTAssertNil([UIColor ot_colorWithHexString:@"0000000"]);
    XCTAssertNil([UIColor ot_colorWithHexString:@"00000G"]);
    XCTAssertNil([UIColor ot_colorWithHexString:@"00000"]);
    XCTAssertNil([UIColor ot_colorWithHexString:@"0000"]);
    XCTAssertNil([UIColor ot_colorWithHexString:@"000"]);
    XCTAssertNil([UIColor ot_colorWithHexString:@"00"]);
    XCTAssertNil([UIColor ot_colorWithHexString:@"0"]);
    XCTAssertNil([UIColor ot_colorWithHexString:@"$000000"]);
}

@end
