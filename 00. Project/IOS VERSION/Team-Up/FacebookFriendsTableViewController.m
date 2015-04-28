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

    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for(int i = 0; i<[ad.FacebookFriendsArray count]; i++){
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query whereKey:@"facebookID" equalTo:ad.FacebookFriendsArray[i]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            if (!error) {
                [tempArray addObject:results[0][@"username"]];
                NSLog(tempArray[1]);
                [self.tv reloadData];
            } else {
            // The find succeeded.
            NSLog(@"failed to retrieve the object.");
            }
        }];

    }
    NSLog(@"1st %@", self.FBFriendsArray );
    self.FBFriendsArray = tempArray;
   [self.tv reloadData];
[self.FBFriendsArray addObject:@"fads"];
    NSLog(@"facebook friends list");
    NSLog(@"2nd %@", self.FBFriendsArray );
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [self sendInvite];
}

- (void)sendInvite {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invite"
                                                    message:@"Type in username of member to invite"
                                                   delegate:self
                                          cancelButtonTitle:@"Send"
                                          otherButtonTitles:@"Cancel",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0) {
        NSLog(@"%@", [alertView textFieldAtIndex:0].text);
        PFQuery *member = [PFQuery queryWithClassName:@"_User"];
        PFUser *currentUser = [PFUser currentUser];
        
        [member orderByDescending: @"createdAt"];
        [member whereKey:@"username" equalTo:[alertView textFieldAtIndex:0].text];
        [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            if (!error && results.count != 0 && ![[alertView textFieldAtIndex:0].text isEqualToString:currentUser.username]) {
                NSLog(@"%d", results.count);
                self.array = results;
                self.ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                PFUser *currentUser = [PFUser currentUser];
                PFObject *invite = [PFObject objectWithClassName:@"Invite"];
                invite[@"inviter"] = currentUser.username;
                
                // modify this to take username from cell
                invite[@"invitee"] = [alertView textFieldAtIndex:0].text;
                
                invite[@"groupId"] = [self.ad.myGlobalArray objectAtIndex:0][@"groupId"];
                [invite saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        // The object has been saved.
                        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Invite sent"
                                                                         message: @""
                                                                        delegate:nil
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil];
                        [alert2 show];
                    } else {
                        // There was a problem, check error.description
                        NSLog(@"%@",error.description);
                    }
                }];
            } else if([[alertView textFieldAtIndex:0].text isEqualToString:currentUser.username]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"You cannot invite youself"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"User does not exist"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            }
        }];
    }
    else {
        NSLog(@"CANCEL");
    }
}


@end
