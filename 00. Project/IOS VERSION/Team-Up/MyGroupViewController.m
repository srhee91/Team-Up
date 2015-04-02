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
    ad.currentGroupImage = [UIImage imageWithData:[[ad.myGlobalArray objectAtIndex:0][@"image"] getData]];
    if(ad.currentGroupImage == nil)
        ad.currentGroupImage = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"QM" ofType:@".jpeg"]];
    [self.imgGroup setImage:ad.currentGroupImage];
    NSString *name = [ad.myGlobalArray objectAtIndex:0][@"groupname"];
    self.navbar.title = name;
    self.gn.text = name;
    self.an.text = [ad.myGlobalArray objectAtIndex:0][@"admin"];
    self.cat.text = [ad.myGlobalArray objectAtIndex:0][@"categoryName"];
    self.des.text = [ad.myGlobalArray objectAtIndex:0][@"description"];
    self.meetButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.meetButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.meetButton setTitle:@"Meetings" forState:UIControlStateNormal];
    if([currentUser.username isEqualToString:[ad.myGlobalArray objectAtIndex:0][@"admin"]]) {
            [self.editButton addTarget:self
                                action:@selector(edit)
                        forControlEvents:UIControlEventTouchUpInside];
            [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
            [self.membersButton setTitle:@"Member" forState:UIControlStateNormal];
            NSLog(@"I AM THE ADMIN");
    }
    else {
        [self.editButton setTitle:@"" forState:UIControlStateNormal];
        [self.membersButton setHidden:YES];

        NSLog(@"NOT ADMIN");
    }
    PFQuery *member = [PFQuery queryWithClassName:@"Member"];
    [member orderByDescending: @"createdAt"];
    [member whereKey:@"username" notEqualTo:currentUser.username];
    [member whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        //join button
        self.navbar.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Join" style:UIBarButtonItemStylePlain target:self action:@selector(join)];
        if (!error) {
            self.array = results;
            NSLog(@"made it");
            [self.tv setDelegate:self];
            [self.tv setDataSource:self];
            [self.tv reloadData];
        } else {
            // The find succeeded.
            NSLog(@"failed to retrieve the object.");
        }
        PFQuery *members = [PFQuery queryWithClassName:@"Member"];
        [members whereKey:@"username" equalTo:currentUser.username];
        [members whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
        [members findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            NSLog(@"username %@",[results objectAtIndex:0][@"username"]);
            NSLog(@"error %@",error.description);
            int k = 0;
            if([currentUser.username isEqualToString:[results objectAtIndex:0][@"username"]]) {
                //leave button
                self.navbar.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Leave" style:UIBarButtonItemStylePlain target:self action:@selector(leave)];
                k = 1;
            }
        }];
    }];
    PFQuery *meetings = [PFQuery queryWithClassName:@"Meeting"];
    NSDate *today = [NSDate date];
    [meetings orderByAscending:@"date"];
    [meetings whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [meetings whereKey:@"date" greaterThan:today];
    [meetings findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        self.meetingArray = results;
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
}

- (void)edit {
    [self performSegueWithIdentifier:@"toEditGroup" sender:self];
}

- (void)join {
    PFUser *currentUser = [PFUser currentUser];
    PFObject *member = [PFObject objectWithClassName:@"Member"];
    member[@"username"] = currentUser.username;
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    member[@"groupId"] = [ad.myGlobalArray objectAtIndex:0][@"groupId"];
    [member saveInBackground];
    self.navbar.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Leave" style:UIBarButtonItemStylePlain target:self action:@selector(leave)];
}

- (void)leave {
    PFUser *currentUser = [PFUser currentUser];
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    PFQuery *mem = [PFQuery queryWithClassName:@"Member"];
    [mem whereKey:@"username" equalTo:currentUser.username];
    [mem whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [mem findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        [[results objectAtIndex:0] delete];
        PFQuery *findadmin = [PFQuery queryWithClassName:@"Member"];
        [findadmin whereKey:@"username" equalTo:[ad.myGlobalArray objectAtIndex:0][@"admin"]];
        NSLog([ad.myGlobalArray objectAtIndex:0][@"admin"]);
        [findadmin whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
        if([[findadmin findObjects] count] == 0) {  //If there is no longer an admin...
            NSLog(@"ADMIN LEFT");
            PFQuery *newadmin = [PFQuery queryWithClassName:@"Member"];
            [newadmin whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
            [newadmin orderByAscending:@"createdAt"];
            [newadmin findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
                if([results count] == 0) {
                    //Delete group
                    [[ad.myGlobalArray objectAtIndex:0] delete];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Group Deleted"
                                                                    message:@"There are no more members in the group."
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    alert.cancelButtonIndex = 0;
                    [alert show];
                    
                }
                else {
                    //Make user @ object 0 admin
                    [ad.myGlobalArray objectAtIndex:0][@"admin"] = [results objectAtIndex:0][@"username"];
                    [[ad.myGlobalArray objectAtIndex:0] saveInBackground];
                }
            }];
        }
    }];
    self.navbar.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Join" style:UIBarButtonItemStylePlain target:self action:@selector(join)];
   // sleep(2);
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *) alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex ==0) {
        [self performSegueWithIdentifier:@"toMyProfilePage" sender:self];
        //[self dismissViewControllerAnimated:YES];
    }
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
