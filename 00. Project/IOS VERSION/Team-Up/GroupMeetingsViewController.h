//
//  GroupMeetingsViewController.h
//  Team-Up
//
//  Created by Travis on 3/20/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupMeetingsViewController : UITableViewController
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *scheduleButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
- (IBAction)unwindToMeetings:(UIStoryboardSegue*)segue;
@end
