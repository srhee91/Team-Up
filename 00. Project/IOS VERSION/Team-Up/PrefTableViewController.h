//
//  PrefTableViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/5/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrefTableViewController : UITableViewController{
    NSIndexPath* checkedIndexPath;
}

@property (strong,nonatomic) NSArray *section1;
@property (strong,nonatomic) NSArray *section2;
@property (strong,nonatomic) NSArray *section3;
@property (strong,nonatomic) NSArray *section4;
@property (strong,nonatomic) NSArray *section5;
@property (strong,nonatomic) NSArray *section6;
@property (strong,nonatomic) NSArray *section7;
@property (strong,nonatomic) NSArray *section8;
@property (strong,nonatomic) NSMutableArray *array;
@property (nonatomic, retain) NSIndexPath* checkedIndexPath;

@end
