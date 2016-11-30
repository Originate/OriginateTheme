//
//  OTERemoteThemeViewController.m
//  OriginateTheme-Example
//
//  Created by Robert Weindl on 2016-09-15.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "OTERemoteThemeViewController.h"

static NSString * const kRemoteThemeURLString = @"https://raw.githubusercontent.com/Originate/OriginateTheme/rw-theme-parser-generator/Example/Themes/Remote.json";

@interface OTERemoteThemeViewController ()

#pragma mark - Properties
@property (nonatomic, strong) OTTheme *theme;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *captionLabel;

@end

@implementation OTERemoteThemeViewController

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Simulate fetching and applying of a remote theme declaration with a two second delay.
    // As long remote theme gets fetched or fetch fails the compiled fallback will be displayed.
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2.0);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        [self downloadRemoteThemeFromURL:[NSURL URLWithString:kRemoteThemeURLString]];
    });
}

#pragma mark - OTERemoteThemeViewController

- (void)applyThemeToViews
{
    self.view.backgroundColor = self.theme.colors.primaryColor;
    
    self.titleLabel.font = self.theme.fonts.defaultFont;
    self.titleLabel.textColor = self.theme.colors.titleColor;
    self.captionLabel.font = self.theme.fonts.defaultLightFont;
    self.captionLabel.textColor = self.theme.colors.captionColor;
    
    [self.tabBarController.tabBar setTintColor:self.theme.components.tabBarTintColor];
}

- (void)downloadRemoteThemeFromURL:(NSURL *)remoteThemeURL
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:remoteThemeURL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
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
              NSString *documentsDirectory = [paths firstObject];
              NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Remote.json"];
              
              [data writeToFile:dataPath atomically:YES];
              
              strongSelf.theme = [[OTTheme alloc] initWithThemeFileAtURL:[NSURL URLWithString:dataPath]];
              [strongSelf setTheme:strongSelf.theme];
          });
      }] resume];
}

#pragma mark - <OTThemeable>

- (void)setTheme:(OTTheme *)theme
{
    _theme = theme;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf applyThemeToViews];
    });
}

@end
