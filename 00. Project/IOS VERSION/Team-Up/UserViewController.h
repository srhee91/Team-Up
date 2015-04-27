//
//  UserViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/6/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *un;
@property (weak, nonatomic) IBOutlet UILabel *em;
@property (weak, nonatomic) IBOutlet UILabel *bd;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *gId;
@property (weak, nonatomic) IBOutlet UIImageView *imgPicture;

@end
