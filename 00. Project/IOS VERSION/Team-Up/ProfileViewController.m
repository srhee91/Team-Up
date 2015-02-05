//
//  ProfileViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    self.un.text = currentUser.username;
    self.em.text = currentUser.email;
    self.bd.text = currentUser[@"birthday"];
    self.des.text = currentUser[@"Description"];
}

-(void) dismissKeyboard {
    [self.un resignFirstResponder];
    [self.em resignFirstResponder];
    [self.bd resignFirstResponder];
    [self.des resignFirstResponder];
    [self.submit resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)edit:(id)sender {
    PFUser *user = [PFUser user];
    NSString *username = self.un.text;
    NSString *email = self.em.text;
    if(![self.un.text isEqualToString:@""]&&![self.bd.text isEqualToString:@""]&&![self.em.text isEqualToString:@""]){
        user.username = username;
        user.email = email;
        user[@"birthday"] = self.bd.text;
        user[@"Description"] = self.des.text;
        [user saveInBackground];
        /*[user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"successful");
                // Now Sign Up successful, continue to onto next page*/
                [self performSegueWithIdentifier:@"backtoprofile" sender:sender];
            /*} else {
                NSLog(@"Fail");
                // Sign Up failed, ask for re-input of user information
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorAlertView show];
            }
        }];*/
    }
    else{
        NSLog(@"Missing information");
        //Do not move onto next Page, ask for re-input of information
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
