//
//  MemberTableViewController.m
//  Team-Up
//
//  Created by Bo heon Jeong on 3/22/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "MemberTableViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface MemberTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *MV;
@property (strong, nonatomic) NSString *admin;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) AppDelegate *ad;

@end

@implementation MemberTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addtable];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)addtable{
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self setModalPresentationStyle:UIModalPresentationCurrentContext];
    self.ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.admin = [self.ad.myGlobalArray objectAtIndex:0][@"admin"];
    PFQuery *member = [PFQuery queryWithClassName:@"Member"];
    PFUser *currentUser = [PFUser currentUser];
    
    [member orderByDescending: @"createdAt"];
    [member whereKey:@"username" notEqualTo:currentUser.username];
    [member whereKey:@"groupId" equalTo:[self.ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            self.array = results;
            [self.MV setDelegate:self];
            [self.MV setDataSource:self];
            [self.MV reloadData];
        } else {
            // The find succeeded.
        }
    }];
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
    return [self.array count];
}

- (IBAction)admin:(id)sender {
    NSLog(@"admin changed");
    NSString *admined = @" is now new Admin!";
    self.name = [self.array
                 objectAtIndex: [sender tag]][@"username"];
    PFQuery *groups = [PFQuery queryWithClassName:@"Group"];
    [groups whereKey:@"groupId" equalTo:[self.ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [groups getFirstObjectInBackgroundWithBlock:^(PFObject * object, NSError *error) {
        if (!error) {
            [object setObject:self.name forKey:@"admin"];
            [object saveInBackground];
            [self showPopupWithTitle:@"Admin Change Notification" msg: [NSString stringWithFormat:@"%@,%@", self.name, admined] dismissAfter:3];
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
}

- (IBAction)kick:(id)sender {
    NSString *kicked = @" has been kicked !";
    self.name = [self.array
                 objectAtIndex: [sender tag]][@"username"];
    [NSString stringWithFormat:@"%@,%@", self.name, kicked];
    PFQuery *members = [PFQuery queryWithClassName:@"Member"];
    [members whereKey:@"groupId" equalTo:[self.ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [members whereKey:@"username" equalTo: self.name];
    [members getFirstObjectInBackgroundWithBlock:^(PFObject * object, NSError *error) {
        if (!error) {
            [object deleteInBackground];
            sleep(1);
            [self addtable];
            
            [self showPopupWithTitle:@"Member Kicked Notification" msg: [NSString stringWithFormat:@"%@,%@", self.name, kicked] dismissAfter:3];
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
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
    cell.textLabel.text = [self.array
                           objectAtIndex: [indexPath row]][@"username"];
    
    
    UIButton *adminbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [adminbutton addTarget:self
                    action:@selector(admin:)
          forControlEvents:UIControlEventTouchDown];
    [adminbutton setTitle:@"ADMIN" forState:UIControlStateNormal];
    adminbutton.frame = CGRectMake(190.0f, 5.0f, 50.0f, 30.0f);
    [adminbutton addTarget:self action:@selector(admin:) forControlEvents:UIControlEventTouchUpInside];
    [adminbutton setTag:indexPath.row];
    [cell addSubview:adminbutton];
    
    UIButton *kickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [kickButton addTarget:self
                   action:@selector(kick:)
         forControlEvents:UIControlEventTouchDown];
    [kickButton setTitle:@"KICK" forState:UIControlStateNormal];
    kickButton.frame = CGRectMake(260.0f, 5.0f, 50.0f, 30.0f);
    [kickButton setTag:indexPath.row];
    [cell addSubview:kickButton];
    return cell;
}

- (void)dismissAlert_admin:(UIAlertView *)alertView
{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)dismissAlert_kick:(UIAlertView *)alertView
{
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    sleep(1);
    [self addtable];
}

- (void)showPopupWithTitle:(NSString *)title
                       msg:(NSString *)message
              dismissAfter:(NSTimeInterval)interval
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:nil
                              ];
    [alertView show];
    if ([message containsString:@"Admin"]){
        [self performSelector:@selector(dismissAlert_admin:)
                   withObject:alertView
                   afterDelay:interval
         ];
    }
    else if([message containsString:@"kicked"]){
        [self performSelector:@selector(dismissAlert_kick:)
                   withObject:alertView
                   afterDelay:interval
         ];
    }
}

- (IBAction)sendInvite:(id)sender {
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
