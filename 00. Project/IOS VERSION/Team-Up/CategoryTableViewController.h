//
//  CategoryTableViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CategoryTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISearchBar *txtSearchBar;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property (strong, nonatomic)NSMutableArray *filteredGroups;
@property (strong,nonatomic) NSArray *allGroups;
@property (strong,nonatomic) NSArray *allCategories;
@property (strong,nonatomic) NSMutableArray *filteredCategories;
@property (weak,nonatomic) NSNumber *privacy;
@property (strong,nonatomic) NSArray *array_temp;



//A stack containing the parent categories used to get to the current category.
@property (strong, nonatomic) NSMutableArray *parentCategories;

@end
