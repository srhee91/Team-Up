//
//  DeleteAccountViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "DeleteAccountViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface DeleteAccountViewController ()

@end

@implementation DeleteAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

-(void) dismissKeyboard {
    [self.password resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)delete:(id)sender{
    PFUser *currentUser = [PFUser currentUser];
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([self.password.text isEqualToString:ad.storePassword]){
        [[PFUser currentUser] deleteInBackground];

/*        PFUser *user = [PFUser logInWithUsername:currentUser.username password:ad.storePassword];
        user.username = @" ";
        user.email = @"";
        user[@"birthday"] = @"";
        user[@"Description"] = @"";*/
       // [user save];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account Deleted"
                                                        message:@"Your account has been deleted"
                                                        delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [alert show];
        [self performSegueWithIdentifier:@"accountdeleted" sender:self];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password"
                                                        message:@"Retry"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        //Do not move onto next Page, ask for re-input of information
        //currentUser = user;
    }
    
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
