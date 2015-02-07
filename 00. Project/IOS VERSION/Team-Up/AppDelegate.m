//
//  AppDelegate.m
//  Team-Up
//
//  Created by Kartik Sawant on 1/23/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//


#import "AppDelegate.h"
#import "Parse/parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
//@synthesize myGlobalArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.myGlobalArray = [[NSMutableArray alloc] init];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:95.0/255.0 green:126.0/255.0 blue:193.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
        [Parse setApplicationId:@"YW9dg2nCBuBU1xZ4tkR36WTkABoVZe3nAowKYXLJ"
                  clientKey:@"XqEclPHvPjeHXKgDXtNsYLUUIjb5NzSfSMhnaEhL"];
        return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
