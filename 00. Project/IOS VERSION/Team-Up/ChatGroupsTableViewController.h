//
//  ChatGroupsTableViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/19/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatGroupsTableViewController : UITableViewController

@property (strong,nonatomic) NSArray *gId;
@property (strong, nonatomic) NSArray *array;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@end
