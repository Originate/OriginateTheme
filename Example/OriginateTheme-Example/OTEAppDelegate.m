//
//  OTEAppDelegate.m
//  OriginateTheme-Example
//
//  Created by Robert Weindl on 2016-09-15.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "OTEAppDelegate.h"
#import "OTEViewController.h"

static NSString * const kRemoteThemeURLString = @"https://raw.githubusercontent.com/Originate/OriginateTheme/rw-theme-parser-generator/Example/Themes/Remote.json";

@interface OTEAppDelegate ()

#pragma mark - Properties
@property (nonatomic, strong) OTEViewController *viewController;
@property (nonatomic, strong) OTTheme *theme;

@end

@implementation OTEAppDelegate

#pragma mark - OTEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initialize the view controller with default theme class. This class provides access to the defined styles inside the provided Theme.json.
    [self.viewController setTheme:self.theme];
    
    // Download a new remove theme and replace the compiled theme class in runtime. Simulate that files is stored on disk.
    [self downloadRemoteThemeFromURL:[NSURL URLWithString:kRemoteThemeURLString]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)downloadRemoteThemeFromURL:(NSURL *)remoteThemeURL
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:remoteThemeURL];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    __weak typeof(self) weakSelf = self;
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (error) {
            NSLog(@"Received error: %@", error);
            return;
        }
        
        if (!data) {
            NSLog(@"Received no data!");
            return;
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Remote.json"];
    
            [data writeToFile:dataPath atomically:YES];
            
            strongSelf.theme = [[OTTheme alloc] initWithStyleDefinitionFileAtURL:[NSURL URLWithString:dataPath]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.viewController setTheme:strongSelf.theme];
            });
        });
    }] resume];
}

#pragma mark - OTEAppDelegate (Properties)

- (OTEViewController *)viewController
{
    if (!_viewController) {
        _viewController = [[OTEViewController alloc] init];
    }
    return _viewController;
}

- (OTTheme *)theme
{
    if (!_theme) {
        _theme = [[OTTheme alloc] init];
    }
    return _theme;
}

@end
