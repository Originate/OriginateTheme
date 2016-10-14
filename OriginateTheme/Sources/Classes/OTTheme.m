//
//  OTTheme.m
//  OriginateTheme
//
//  Created by Robert Weindl on 2016-09-15.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "OTTheme.h"
#import "OTColors.h"
#import "OTComponents.h"
#import "OTFonts.h"

@interface OTTheme()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *themeDictionary;

@property (nonatomic, strong, readwrite) OTColors *colors;
@property (nonatomic, strong, readwrite) OTComponents *components;
@property (nonatomic, strong, readwrite) OTFonts *fonts;

@end

@implementation OTTheme

#pragma mark - OTTheme

- (instancetype)initWithThemeFileAtURL:(NSURL *)URL
{
    self = [super init];
    
    if (self) {
        NSError *error;
        NSString *json = [NSString stringWithContentsOfFile:[URL relativePath]
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
        
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        
        if (data.length == 0) {
            NSLog(@"OriginateTheme > Attempting to load non-existent theme. Falling back to default values.");
        }
        else {
            NSDictionary *themeDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:0
                                                                              error:&error];
            if (error) {
                NSLog(@"OriginateTheme > Invalid theme. Falling back to default values.");
            }
            
            _themeDictionary = themeDictionary;
        }
    }
    
    return self;
}

- (instancetype)initWithTheme:(NSDictionary *)themeDictionary
{
    if (!themeDictionary) {
        return nil;
    }
    
    self = [super init];
    
    if (self) {
        _themeDictionary = themeDictionary;
    }
    
    return self;
}

#pragma mark - OTTheme (Properties)

- (OTColors *)colors
{
    if (!_colors) {
        _colors = [[OTColors alloc] initWithDictionary:self.themeDictionary];
    }
    
    return _colors;
}

- (OTComponents *)components
{
    if (!_components) {
        _components = [[OTComponents alloc] initWithDictionary:self.themeDictionary];
    }
    
    return _components;
}

- (OTFonts *)fonts
{
    if (!_fonts) {
        _fonts = [[OTFonts alloc] initWithDictionary:self.themeDictionary];
    }
    
    return _fonts;
}

@end
