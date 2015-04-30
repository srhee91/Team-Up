//
//  FacebookFriendsTableViewController.h
//  Team-Up
//
//  Created by YIYANG PAN on 4/27/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface FacebookFriendsTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *mv;
@property (strong, nonatomic) NSMutableArray *FBFriendsArray;
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
@property (strong, nonatomic) IBOutlet UITableView *tv;
@property (strong,nonatomic) NSArray *gId;
@property (strong,nonatomic) NSArray *array;
@end
