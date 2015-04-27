//
//  ViewProfileViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/4/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "ViewProfileViewController.h"
#import <Parse/Parse.h>
#include <stdlib.h>
#import "AppDelegate.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface ViewProfileViewController ()

@end

@implementation ViewProfileViewController

- (void)viewDidLoad {
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"%@",currentUser[@"initial"]);
    if(currentUser[@"initial"]){
        NSLog(@"first time");
        currentUser.username = @"temp"; //input username;
        currentUser[@"initial"] = [NSNumber numberWithBool:NO];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *fbUser = [PFUser user];

    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection,id result, NSError *error) {
        // handle response
        if (!error) {
            NSDictionary *userData = (NSDictionary *)result;
            NSLog(@"no error");
            int random = rand()%100;
            currentUser.email = userData[@"email"];
            currentUser[@"birthday"] = userData[@"birthday"];
        }
        else{
            NSLog(@"error");
        }
    }];
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // The currentUser saved successfully.
        } else {
            // There was an error saving the currentUser.
            NSLog(@"smae user naem");
        }
    }];

    self.un.text = currentUser.username;
    self.em.text = currentUser.email;
    self.bd.text = currentUser[@"birthday"];
    self.des.text = currentUser[@"Description"];
    PFQuery *member = [PFQuery queryWithClassName:@"Member"];
    [member orderByDescending: @"groupId"];
    [member whereKey:@"username" equalTo:currentUser.username];
    [member selectKeys:@[@"groupId"]];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        //NSLog(@"HERE");
        self.gId = results;
        NSInteger counter = [results count];
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
    PFQuery *invite = [PFQuery queryWithClassName:@"Invite"];
    [invite whereKey:@"invitee" equalTo:currentUser.username];
    [invite findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if(!error && results.count != 0) {
            self.inviteArray = results;
            PFQuery *groups = [PFQuery queryWithClassName:@"Group"];
            [groups whereKey:@"groupId" equalTo:[results objectAtIndex:0][@"groupId"]];
            [groups findObjectsInBackgroundWithBlock:^(NSArray *results2, NSError *error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Group Invite"
                                                                message:[NSString stringWithFormat:@"%@ has invited you to %@",[results objectAtIndex:0][@"inviter"],[results2 objectAtIndex:0][@"groupname"]]
                                                               delegate: self
                                                      cancelButtonTitle:@"Yes"
                                                      otherButtonTitles:@"No", nil];
                [alert show];
                //sleep(1);
            }];
        }
        else {
            
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"HERE");
    if(buttonIndex == 0) {
        PFObject *member = [PFObject objectWithClassName:@"Member"];
        member[@"username"] = currentUser.username;
        member[@"groupId"] = [self.inviteArray objectAtIndex:0][@"groupId"];
        [member saveInBackground];
        PFQuery *invite = [PFQuery queryWithClassName:@"Invite"];
        [invite whereKey:@"invitee" equalTo:currentUser.username];
        [invite whereKey:@"groupId" equalTo:[self.inviteArray objectAtIndex:0][@"groupId"]];
        [invite findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            int i = 0;
            while (i < results.count) {
                [[results objectAtIndex:i] deleteInBackground];
                i++;
            }
            //[self viewDidAppear:(FALSE)];
        }];
        NSLog(@"YES");
        [self viewDidAppear:(FALSE)];
    }
    else {
        PFQuery *invite = [PFQuery queryWithClassName:@"Invite"];
        [invite whereKey:@"invitee" equalTo:currentUser.username];
        [invite whereKey:@"groupId" equalTo:[self.inviteArray objectAtIndex:0][@"groupId"]];
        [invite findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            int i = 0;
            while (i < results.count) {
                [[results objectAtIndex:i] deleteInBackground];
                i++;
            }
        }];
        NSLog(@"NO");
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
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
    [self performSegueWithIdentifier:@"toMyGroups" sender:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
