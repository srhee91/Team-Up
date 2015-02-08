//
//  AppDelegate.h
//  Team-Up
//
//  Created by Kartik Sawant on 1/23/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableArray * myGlobalArray;
    NSMutableString * storePassword;
}
//NSMutableArray * myGlobalArray;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSMutableArray * myGlobalArray;
@property (nonatomic, retain) NSMutableString * storePassword;

@end

