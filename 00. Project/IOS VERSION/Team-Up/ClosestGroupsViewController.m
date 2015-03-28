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

    
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];

    self.navbar.title = @"Closest groups from you";
            // get the user preferences and store in the self.array
            
    [self getGroupByGeoPoints];
    NSLog(@"After : print the group name in self.locationObjectsArray");
    //NSLog([self.locationObjectsArray objectAtIndex: 0][@"geoPoint"] );
    
    
    
    
}

//- (void)getGroupByPreference {
//    // get the groups by preferences
//    NSLog(@"prefArray count of array %d",[self.prefArray count] );
//    for(PFObject *preference in self.prefArray){
//        PFQuery *group = [PFQuery queryWithClassName:@"Group"];
//        [group whereKey:@"category" equalTo:[preference objectForKey:@"categoryID"]];
//        [group findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (!error) {
//                
//                // get the user preferences and store in the self.groupArray
//                for(int i = 0; i < [objects count]; i++){
//                    [self.groupArray addObject:objects[i]];
//                    //                    NSLog(@"Inplace :print the group name in self.groupArray");
//                    //                    NSLog([self.groupArray objectAtIndex: i][@"groupname"] );
//                    
//                }
//                
//                // Why self.groupArray will lose content outside of loop?
//                [self.tv setDelegate:self];
//                [self.tv setDataSource:self];
//                [self.tv reloadData];
//                
//            } else {
//                // The find succeeded.
//                NSLog(@"failed to retrieve the object.");
//            }
//        }];
//        
//    }
//}

- (void)getGroupByGeoPoints {

    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            // do something with the new geoPoint
            // User's location
            PFGeoPoint *userGeoPoint = geoPoint;
            // Create a query for places
            PFQuery *query = [PFQuery queryWithClassName:@"Group"];
            // Interested in locations near user.
            [query whereKey:@"geoPoint" nearGeoPoint:userGeoPoint withinMiles:10.0];
            // Limit what could be a lot of points.
            query.limit = 5;
            // Final list of objects
            self.locationObjectsArray = [query findObjects];
            
            [self.tv setDelegate:self];
            [self.tv setDataSource:self];
            [self.tv reloadData];
        }
        else{
            NSLog(@"Location Service error");
        
        }
    }];
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
    NSLog(@"count of array %d",[self.locationObjectsArray count]);
    return [self.locationObjectsArray count];
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
    cell.textLabel.text = [self.locationObjectsArray
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
