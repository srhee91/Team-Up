//
//  AppDelegate.m
//  Team-Up
//
//  Created by Kartik Sawant on 1/23/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//


#import "AppDelegate.h"
#import "Parse/parse.h"
#import <FacebookSDK/FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>


@interface AppDelegate ()

@end

@implementation AppDelegate
//@synthesize myGlobalArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.myGlobalArray = [[NSMutableArray alloc] init];
    self.storePassword = [[NSMutableString alloc] init];
    self.fb = [[NSMutableString alloc] init];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeTextShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
                                                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
                                                           UITextAttributeFont: [UIFont fontWithName:@"Arial-Bold" size:0.0],
                                                           }];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:10.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
        [Parse setApplicationId:@"YW9dg2nCBuBU1xZ4tkR36WTkABoVZe3nAowKYXLJ"
                  clientKey:@"XqEclPHvPjeHXKgDXtNsYLUUIjb5NzSfSMhnaEhL"];
    [PFFacebookUtils initializeFacebook];
        return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}
- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[PFFacebookUtils session] close];
}

@end
