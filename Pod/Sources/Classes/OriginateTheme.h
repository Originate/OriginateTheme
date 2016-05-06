//
//  OriginateTheme.h
//  OriginateUI
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import UIKit;

#import "UIColor+OriginateThemeHex.h"

#import "OriginateThemeColors.h"
#import "OriginateThemeComponents.h"
#import "OriginateThemeFonts.h"

@interface OriginateTheme : NSObject

#pragma mark - Properties
@property (nonatomic, strong, readonly) OriginateThemeColors *colors;
@property (nonatomic, strong, readonly) OriginateThemeFonts *fonts;
@property (nonatomic, strong, readonly) OriginateThemeComponents *components;

#pragma mark - Methods
- (instancetype)initWithStyleDefinitionFileAtURL:(NSURL *)URL;

@end
