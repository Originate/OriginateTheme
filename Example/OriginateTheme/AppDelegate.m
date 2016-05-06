//
//  AppDelegate.m
//  OriginateUI
//
//  Created by Philip Kluz on 9/22/15.
//  Copyright (c) 2015 originate.com. All rights reserved.
//

#import "AppDelegate.h"
#import "MyThemableViewController.h"
#import "MyTheme.h"

@interface AppDelegate ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) MyTheme *theme;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.theme = [[MyTheme alloc] init];
    
    MyThemableViewController *themableViewController = [[MyThemableViewController alloc] initWithTheme:self.theme];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:themableViewController];
    
    self.window.rootViewController = navigationController;
    
    [self applyTheme:self.theme];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applyTheme:(MyTheme *)theme
{
    [[UINavigationBar appearance] setBarTintColor:theme.navigationBarBackgroundColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : theme.navigationBarTextColor }];
    [[UINavigationBar appearance] setTranslucent:NO];
}

@end
