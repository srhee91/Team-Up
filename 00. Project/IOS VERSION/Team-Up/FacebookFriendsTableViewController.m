//
//  FacebookFriendsTableViewController.m
//  Team-Up
//
//  Created by YIYANG PAN on 4/27/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FacebookFriendsTableViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface FacebookFriendsTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *MV;
@property (strong, nonatomic) NSString *admin;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) AppDelegate *ad;

@end

@implementation FacebookFriendsTableViewController

- (void)viewDidLoad {
    //[super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
     self.navbar.title = @"Facebook Friends in TeamUp";

    self.FBFriendsArray = [[NSMutableArray alloc] init];
    [self.tv reloadData];
    for(int i = 0; i<[ad.FacebookFriendsArray count]; i++){
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query whereKey:@"facebookID" equalTo:ad.FacebookFriendsArray[i]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            if (!error) {
                [self.FBFriendsArray addObject:results[0][@"username"]];
                NSLog(@"%@", self.FBFriendsArray );
                //[self.tv setDelegate:self];
               // [self.tv setDataSource:self];
                     [self.tv reloadData];
            } else {
            // The find succeeded.
            NSLog(@"failed to retrieve the object.");
            }
        }];

    }
    NSLog(@"1 %@", self.FBFriendsArray );
   [self.tv reloadData];
[self.FBFriendsArray addObject:@"fads"];
    NSLog(@"facebook friends list");
    NSLog(@"2 %@", self.FBFriendsArray );
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"FB count");
    NSLog(@"%d", [self.FBFriendsArray count]);
    return [self.FBFriendsArray count];

}

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
    [self.tv reloadData];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    cell.textLabel.text = [self.FBFriendsArray
                           objectAtIndex: [indexPath row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}


@end
