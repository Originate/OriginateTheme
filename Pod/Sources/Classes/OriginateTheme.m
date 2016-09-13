//
//  OriginateTheme.m
//  OriginateTheme
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OriginateTheme.h"
#import "OriginateThemeColors.h"
#import "OriginateThemeComponents.h"
#import "OriginateThemeFonts.h"

@interface OriginateTheme()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@property (nonatomic, strong, readwrite) OriginateThemeColors *colors;
@property (nonatomic, strong, readwrite) OriginateThemeComponents *components;
@property (nonatomic, strong, readwrite) OriginateThemeFonts *fonts;

@end

@implementation OriginateTheme

#pragma mark - OriginateUI

- (instancetype)initWithStyleDefinitionFileAtURL:(NSURL *)URL
{
    self = [super init];
    
    if (self) {
        NSError *error;
        NSString *json = [NSString stringWithContentsOfFile:[URL relativePath]
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
        
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *definition = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&error];
        if (error) {
            NSLog(@"OriginateTheme > Invalid Style Definition. Falling Back to Default Values.");
        }
        
        _definition = definition;
    }
    
    return self;
}

#pragma mark - OriginateUI (Properties)

- (OriginateThemeColors *)colors
{
    if (!_colors) {
        _colors = [[OriginateThemeColors alloc] initWithDictionary:self.definition];
    }
    
    return _colors;
}

- (OriginateThemeComponents *)components
{
    if (!_components) {
        _components = [[OriginateThemeComponents alloc] initWithDictionary:self.definition];
    }
    
    return _components;
}

- (OriginateThemeFonts *)fonts
{
    if (!_fonts) {
        _fonts = [[OriginateThemeFonts alloc] initWithDictionary:self.definition];
    }
    
    return _fonts;
}

@end
