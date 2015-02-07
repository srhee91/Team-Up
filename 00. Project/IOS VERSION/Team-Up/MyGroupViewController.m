//
//  MyGroupViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/6/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "MyGroupViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
@interface MyGroupViewController ()

@end

@implementation MyGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *name = [ad.myGlobalArray objectAtIndex:0][@"groupname"];
    self.navbar.title = name;
    self.gn.text = name;
    self.an.text = [ad.myGlobalArray objectAtIndex:0][@"admin"];
    self.cat.text = [ad.myGlobalArray objectAtIndex:0][@"categoryName"];
    self.des.text = [ad.myGlobalArray objectAtIndex:0][@"description"];
    PFQuery *member = [PFQuery queryWithClassName:@"Member"];
    [member orderByDescending: @"createdAt"];
    [member whereKey:@"username" notEqualTo:currentUser.username];
    [member whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            self.array = results;
            NSLog(@"made it");
            NSLog(@"%@",results);
            [self.tv setDelegate:self];
            [self.tv setDataSource:self];
            [self.tv reloadData];
        } else {
            // The find succeeded.
            NSLog(@"failed to retrieve the object.");
        }
    }];

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
    NSLog(@"count of array %d",[self.array count]);
    return [self.array count];
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
    cell.textLabel.text = [self.array
                           objectAtIndex: [indexPath row]][@"username"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSLog(@"%i",indexPath.row);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [ad.myGlobalArray removeAllObjects];
    [ad.myGlobalArray addObject:[self.array objectAtIndex:[indexPath row]]];
    NSLog(@"%@",ad.myGlobalArray);
    [self performSegueWithIdentifier:@"toUserProfile" sender:self];
}

@end