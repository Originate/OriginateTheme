//
//  MyTheme.m
//  OriginateUI
//
//  Created by Philip Kluz on 9/22/15.
//  Copyright © 2015 originate.com. All rights reserved.
//

#import "MyTheme.h"

@implementation MyTheme

#pragma mark - NSObject

- (instancetype)init
{
    self = [super initWithStyleDefinitionFileAtURL:[[NSBundle mainBundle] URLForResource:@"StyleDefinition" withExtension:@"json"]];
    return self;
}

#pragma mark - MyTheme

- (UIColor *)rootViewBackgroundColor
{
    return self.components.viewBackgroundColor;
}

- (UIColor *)navigationBarBackgroundColor
{
    return self.components.navigationBarBackgroundColor;
}

- (UIColor *)navigationBarTextColor
{
    return self.components.navigationBarTextColor;
}

@end
