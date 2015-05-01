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
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"%@",currentUser[@"initial"]);
    if([currentUser[@"initial"]intValue] != 1){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Type in Username or Click Cancel for Automated Username" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] ;
        alertView.tag = 2;
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        currentUser[@"initial"] = [NSNumber numberWithBool:YES];
        [alertView show];
    }
    NSMutableArray * m_allFriends;
    m_allFriends = [[NSMutableArray alloc] init];
    [FBRequestConnection startWithGraphPath:@"me/friends"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                                 completionHandler:^(
                                                     FBRequestConnection *connection,
                                                     id result,
                                                     NSError *error
                                                     ) {
                              NSString *result_friends = [NSString stringWithFormat: @"%@",result];
                              NSArray *friendList = [result objectForKey:@"data"];
                              //Data is in friendList;
                                AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                                     NSLog(@"Facebook friends");
                                     ad.FacebookFriendsArray = [[NSMutableArray alloc] init];
                                     for(int i =0; i<[friendList count];i++){
                                         [ad.FacebookFriendsArray addObject:friendList[i][@"id"]];
                                     }
                                     NSLog(@"%@",ad.FacebookFriendsArray);
                              
                              [m_allFriends addObjectsFromArray: friendList];
                          }];
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
        // handle response
        if (!error) {
            //NSDictionary *userData = (NSDictionary *)result;
            currentUser.email = [user objectForKey:@"email"];
            currentUser[@"birthday"] = [user objectForKey:@"birthday"];
            currentUser[@"facebookID"] = user.id;
            //NSLog(@"friends %@",userData[@"user_friends"]);
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
    
    
    //Load profile image
    PFFile *imgFile = [PFUser currentUser][@"image"];
    UIImage *profilePicture = [UIImage imageWithData:[imgFile getData]];
    if(profilePicture == nil)
        self.imgPicture.image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"QM" ofType:@".jpeg"]];
    else
        [self.imgPicture setImage:profilePicture];
    
    
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
    if(buttonIndex == 0) {
        NSLog(@" button 0");
        if([currentUser[@"initial"]intValue] == 1){
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
            }];
            NSLog(@"YES");
            [self viewDidLoad];
        }
        else{
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection,id result, NSError *error) {
                // handle response
                if (!error) {
                    NSDictionary *userData = (NSDictionary *)result;
                    int random = rand()%100;
                    currentUser.username =[NSString stringWithFormat:@"%@%@", [NSString stringWithFormat:@"%@", userData[@"last_name"]], [NSString stringWithFormat:@"%d",random]];
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
                    //NSLog(@"smae user naem");
                }
            }];
            currentUser[@"initial"] = [NSNumber numberWithBool:YES];
            sleep(1);
            [self viewDidLoad];
        }
        
    }
    else if(buttonIndex == 1){
        NSLog(@" button 1");
        if([currentUser[@"initial"]intValue] == 1){
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
        else{
            UITextField * alertTextField = [alertView textFieldAtIndex:0];
            NSLog(@"alerttextfiled - %@",alertTextField.text);
            PFUser *currentUser = [PFUser currentUser];
            
            currentUser[@"initial"] = [NSNumber numberWithBool:YES];
            currentUser.username = alertTextField.text;
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    // The currentUser saved successfully.
                } else {
                    // There was an error saving the currentUser.
                    
                }
            }];
            currentUser[@"initial"] = [NSNumber numberWithBool:YES];
            sleep(1);
            
            [self viewDidLoad];
        }

    }
    else{
        
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
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UIImageView *thumbnail;
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
        
        thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,15.0,15.0,15.0)];
        thumbnail.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:thumbnail];
    //}
    
    // Configure the cell.
    //If image ends up loading, add 5 spaces in empty string.
    cell.textLabel.text = [@"" stringByAppendingString:[self.array
                           objectAtIndex: [indexPath row]][@"groupname"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    NSString *path = @"glyphicons-44-group";
    thumbnail.image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:path ofType:@".png"]];
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
