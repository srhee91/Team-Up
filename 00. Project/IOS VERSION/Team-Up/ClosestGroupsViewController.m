//
//  ClosestGroupsViewController.m
//  Team-Up
//
//  Created by YIYANG PAN on 3/28/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//


#import "ClosestGroupsViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface ClosestGroupsViewController ()

@end

@implementation ClosestGroupsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Array!!!
    self.groupArray = [NSMutableArray array];
    
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    PFQuery *pref = [PFQuery queryWithClassName:@"Preference"];
    [pref whereKey:@"username" equalTo:currentUser.username];
    [pref findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            self.navbar.title = @"Groups we selected for you";
            // get the user preferences and store in the self.array
            self.prefArray = results;
            //NSLog([results objectAtIndex:0][@"categoryID"]);
            
            
            [self getGroupByPreference];
            NSLog(@"After : print the group name in self.groupArray");
            NSLog([self.groupArray objectAtIndex: 0][@"groupname"] );
            
            
        } else {
            // The find succeeded.
            NSLog(@"failed to retrieve the object.");
        }
    }];
    
    
    
}

- (void)getGroupByPreference {
    // get the groups by preferences
    NSLog(@"prefArray count of array %d",[self.prefArray count] );
    for(PFObject *preference in self.prefArray){
        PFQuery *group = [PFQuery queryWithClassName:@"Group"];
        [group whereKey:@"category" equalTo:[preference objectForKey:@"categoryID"]];
        [group findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
                // get the user preferences and store in the self.groupArray
                for(int i = 0; i < [objects count]; i++){
                    [self.groupArray addObject:objects[i]];
                    //                    NSLog(@"Inplace :print the group name in self.groupArray");
                    //                    NSLog([self.groupArray objectAtIndex: i][@"groupname"] );
                    
                }
                
                // Why self.groupArray will lose content outside of loop?
                [self.tv setDelegate:self];
                [self.tv setDataSource:self];
                [self.tv reloadData];
                
            } else {
                // The find succeeded.
                NSLog(@"failed to retrieve the object.");
            }
        }];
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    //[self viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"count of array %d",[self.groupArray count]);
    return [self.groupArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    cell.textLabel.text = [self.groupArray
                           objectAtIndex: [indexPath row]][@"groupname"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSLog(@"%i",indexPath.row);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [ad.myGlobalArray removeAllObjects];
    [ad.myGlobalArray addObject:[self.groupArray objectAtIndex:[indexPath row]]];
    NSLog(@"%@",ad.myGlobalArray);
    [self performSegueWithIdentifier:@"toGroupView" sender:self];
}

@end
