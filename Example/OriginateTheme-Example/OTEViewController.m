//
//  OTEViewController.m
//  OriginateTheme-Example
//
//  Created by Robert Weindl on 2016-09-15.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "OTEViewController.h"

@interface OTEViewController ()

#pragma mark - Properties
@property (nonatomic, strong) OTTheme *theme;

@end

@implementation OTEViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - OTEViewController

- (void)applyThemeToViews
{
    self.view.backgroundColor = self.theme.colors.primaryColor;
}

#pragma mark - OTThemeable

- (void)setTheme:(OTTheme *)theme
{
    _theme = theme;
    
    [self applyThemeToViews];
}

@end
