//
//  ViewProfileViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/4/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *un;
@property (weak, nonatomic) IBOutlet UILabel *em;
@property (weak, nonatomic) IBOutlet UILabel *bd;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *inviteArray;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (strong,nonatomic) NSArray *gId;
@end
