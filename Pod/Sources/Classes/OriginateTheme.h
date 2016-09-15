//
//  OriginateTheme.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-15.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import UIKit;

@class OriginateThemeColors;
@class OriginateThemeComponents;
@class OriginateThemeFonts;

@interface OriginateTheme : NSObject

#pragma mark - Properties
@property (nonatomic, strong, readonly) OriginateThemeColors *colors;
@property (nonatomic, strong, readonly) OriginateThemeFonts *fonts;
@property (nonatomic, strong, readonly) OriginateThemeComponents *components;

#pragma mark - Methods
- (instancetype)initWithStyleDefinitionFileAtURL:(NSURL *)URL;

@end
