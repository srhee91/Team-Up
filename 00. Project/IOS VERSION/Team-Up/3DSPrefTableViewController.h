//
//  3DSPrefTableViewController.h
//  Team-Up
//
//  Created by Kartik Sawant, Yiyang Pan on 3/9/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _DSPrefTableViewController : UITableViewController

@property (strong,nonatomic) NSArray *groups;
@property (strong,nonatomic) NSMutableArray *categories;
@property (strong,nonatomic) NSMutableArray *cellSelected;
@property (strong, nonatomic) NSArray *array;
//@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
//@property (weak, nonatomic) IBOutlet UITableView *tv;

@end
