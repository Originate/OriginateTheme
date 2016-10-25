//
//  OTEAppDelegate.m
//  OriginateTheme-Example
//
//  Created by Robert Weindl on 2016-09-15.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "OTEAppDelegate.h"
#import "OTELocalThemeViewController.h"
#import "OTERemoteThemeViewController.h"

@interface OTEAppDelegate ()

#pragma mark - Properties
@property (nonatomic, strong) OTELocalThemeViewController *localThemeViewController;
@property (nonatomic, strong) OTERemoteThemeViewController *remoteThemeViewController;
@property (nonatomic, strong) OTTheme *theme;

@end

@implementation OTEAppDelegate

#pragma mark - OTEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[self.localThemeViewController, self.remoteThemeViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - OTEAppDelegate (Properties)

- (OTELocalThemeViewController *)localThemeViewController
{
    if (!_localThemeViewController) {
        _localThemeViewController = [[OTELocalThemeViewController alloc] init];
        _localThemeViewController.title = NSLocalizedString(@"Local", @"");
        [_localThemeViewController setTheme:self.theme];
    }
    return _localThemeViewController;
}

- (OTERemoteThemeViewController *)remoteThemeViewController
{
    if (!_remoteThemeViewController) {
        _remoteThemeViewController = [[OTERemoteThemeViewController alloc] init];
        _remoteThemeViewController.title = NSLocalizedString(@"Remote", @"");
        [_remoteThemeViewController setTheme:self.theme];
    }
    return _remoteThemeViewController;
}

- (OTTheme *)theme
{
    if (!_theme) {
        _theme = [[OTTheme alloc] init];
    }
    return _theme;
}

@end
