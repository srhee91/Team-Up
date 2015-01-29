//
//  ChangePrefTableViewControllerMain.h
//  Team-Up
//
//  Created by Kartik Sawant on 1/29/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePrefTableViewControllerMain : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *groups;
}

@property (strong,nonatomic) NSArray *groups;

@end
