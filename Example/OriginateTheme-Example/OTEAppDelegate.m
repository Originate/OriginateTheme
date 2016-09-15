//
//  OTEAppDelegate.m
//  OriginateTheme-Example
//
//  Created by Robert Weindl on 2016-09-15.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "OTEAppDelegate.h"
#import "OTEViewController.h"

@implementation OTEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[OTEViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
