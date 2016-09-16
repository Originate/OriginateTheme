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
/**
 *  Initialize a new OTTheme instance by providing a NSURL to a theme JSON file. After compilation the exposed
 *  properties colors, components and fonts contain as 'fallback' values the definitions specified in the JSON file. 
 *  These 'fallback' values are definied in the JSON file specified by the provided path 'OTTHEME' in the main project.
 *
 *  @param URL The path to the local theme JSON file.
 */
- (instancetype)initWithStyleDefinitionFileAtURL:(NSURL *)URL;

@end
