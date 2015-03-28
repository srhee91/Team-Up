//
//  Header.h
//  Team-Up
//
//  Created by YIYANG PAN on 3/28/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClosestGroupsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *un;
@property (weak, nonatomic) IBOutlet UILabel *em;
@property (weak, nonatomic) IBOutlet UILabel *bd;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
@property (strong, nonatomic) NSArray *prefArray;
@property (strong, nonatomic) NSMutableArray *groupArray;
@property (strong, nonatomic) NSArray *locationObjectsArray;
@property (strong, nonatomic) NSArray *gId;

@end

