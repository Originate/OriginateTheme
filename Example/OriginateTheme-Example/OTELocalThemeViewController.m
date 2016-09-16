//
//  OTELocalThemeViewController.m
//  OriginateTheme-Example
//
//  Created by Robert Weindl on 2016-09-15.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "OTELocalThemeViewController.h"

@interface OTELocalThemeViewController ()

#pragma mark - Properties
@property (nonatomic, strong) OTTheme *theme;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *captionLabel;

@end

@implementation OTELocalThemeViewController

#pragma mark - OTELocalThemeViewController

- (void)applyThemeToViews
{
    self.view.backgroundColor = self.theme.colors.primaryColor;
    
    self.titleLabel.font = self.theme.fonts.defaultFont;
    self.titleLabel.textColor = self.theme.colors.titleColor;
    self.captionLabel.font = self.theme.fonts.defaultLightFont;
    self.captionLabel.textColor = self.theme.colors.captionColor;
    
    [[UITabBar appearance] setBackgroundColor:self.theme.components.tabBarBackgroundColor];
    [[UITabBar appearance] setTintColor:self.theme.components.tabBarTintColor];
}

#pragma mark - OTThemeable

- (void)setTheme:(OTTheme *)theme
{
    _theme = theme;
    
    [self applyThemeToViews];
}

@end
