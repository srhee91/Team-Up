//
//  UserViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/6/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "UserViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *name = [ad.myGlobalArray objectAtIndex:0][@"username"];
    self.navbar.title = name;
    self.un.text = name;
    PFQuery *User = [PFQuery queryWithClassName:@"_User"];
    [User whereKey:@"username" equalTo:[ad.myGlobalArray objectAtIndex:0][@"username"]];
    [User findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            self.em.text = [results objectAtIndex:0][@"email"];
            self.des.text = [results objectAtIndex:0][@"Description"];
            self.bd.text = [results objectAtIndex:0][@"birthday"];
            PFQuery *member = [PFQuery queryWithClassName:@"Member"];
            [member orderByDescending: @"groupId"];
            [member whereKey:@"username" equalTo:name];
            [member selectKeys:@[@"groupId"]];
            NSMutableArray *list = [[NSMutableArray alloc] init];
            [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
                //NSLog(@"HERE");
                self.gId = results;
                NSInteger counter = [results count];
                NSLog(@"counter: %d", counter);
                NSInteger i = 0;
                while(i < counter) {
                    [list addObject: [self.gId
                                      objectAtIndex:i][@"groupId"]];
                    i++;
                    NSLog(@"GROUP ID from list: %@",list);
                    NSLog(@"GROUP ID from gId: %@",[self.gId
                                                    objectAtIndex:0][@"groupId"]);
                }
                //NSLog(@"GROUP ID: %@",list);
                PFQuery *group = [PFQuery queryWithClassName:@"Group"];
                [group orderByAscending: @"groupname"];
                NSLog(@"%@",list);
                [group whereKey:@"groupId" containedIn:list];
                [group findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
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
            }];

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
                           objectAtIndex: [indexPath row]][@"groupname"];
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
    [self performSegueWithIdentifier:@"toGroupProfile" sender:self];
}

@end
