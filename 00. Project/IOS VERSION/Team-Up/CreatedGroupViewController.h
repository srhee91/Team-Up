//
//  CreatedGroupViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/6/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatedGroupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
@property (weak, nonatomic) IBOutlet UILabel *gn;
@property (weak, nonatomic) IBOutlet UILabel *an;
@property (weak, nonatomic) IBOutlet UILabel *cat;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UITableView *tv;

@end
