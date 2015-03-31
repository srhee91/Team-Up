//
//  CategoryGroupViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/7/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryGroupViewController : UITableViewController

@property (strong,nonatomic) NSArray *array;
@property (strong,nonatomic) NSArray *array_temp;
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
@property (strong, nonatomic) IBOutlet UITableView *tv;
@property (weak,nonatomic) NSNumber *privacy;


@end
