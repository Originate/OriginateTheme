//
//  OTTheme.h
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-15.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

@import UIKit;

@class OTColors;
@class OTComponents;
@class OTFonts;

@interface OTTheme : NSObject

#pragma mark - Properties
@property (nonatomic, strong, readonly) OTColors *colors;
@property (nonatomic, strong, readonly) OTComponents *components;
@property (nonatomic, strong, readonly) OTFonts *fonts;

#pragma mark - Methods
- (instancetype)initWithStyleDefinitionFileAtURL:(NSURL *)URL;

@end
