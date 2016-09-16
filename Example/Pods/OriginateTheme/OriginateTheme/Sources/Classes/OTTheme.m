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
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@property (nonatomic, strong, readwrite) OTColors *colors;
@property (nonatomic, strong, readwrite) OTComponents *components;
@property (nonatomic, strong, readwrite) OTFonts *fonts;

@end

@implementation OTTheme

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

- (OTColors *)colors
{
    if (!_colors) {
        _colors = [[OTColors alloc] initWithDictionary:self.definition];
    }
    
    return _colors;
}

- (OTComponents *)components
{
    if (!_components) {
        _components = [[OTComponents alloc] initWithDictionary:self.definition];
    }
    
    return _components;
}

- (OTFonts *)fonts
{
    if (!_fonts) {
        _fonts = [[OTFonts alloc] initWithDictionary:self.definition];
    }
    
    return _fonts;
}

@end
