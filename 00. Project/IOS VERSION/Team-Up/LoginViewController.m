//
//  LoginViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/2/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/parse.h"
#import "AppDelegate.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];
    CGRect frameRect = self.username.frame;
    frameRect.size.height = 45;
    self.username.frame = frameRect;
    frameRect = self.password.frame;
    frameRect.size.height = 45;
    self.password.frame = frameRect;
    self.username.borderStyle = UITextBorderStyleNone;
    self.password.borderStyle = UITextBorderStyleNone;
    //UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    //self.username.leftView = paddingView;
    //self.username.leftViewMode = UITextFieldViewModeAlways;
    //UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    UIImageView *arrows = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"glyphicons-4-user.png"]];
    arrows.frame = CGRectMake(0.0, 0.0, arrows.image.size.width+10.0, arrows.image.size.height);
    arrows.contentMode = UIViewContentModeCenter;
    
    self.username.leftView = arrows;
    self.username.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"glyphicons-204-lock.png"]];
    arrow.frame = CGRectMake(0.0, 0.0, arrow.image.size.width+10.0, arrow.image.size.height);
    arrow.contentMode = UIViewContentModeCenter;
    
    self.password.leftView = arrow;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    //self.password.leftView = paddingView2;
    //self.password.leftViewMode = UITextFieldViewModeAlways;
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}
- (void) updatingFbProfile{
    
}
- (IBAction)fbLogin:(id)sender {
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    

    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        } else {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
               //check for user
                FBRequest *request = [FBRequest requestForMe];
                
                [self performSegueWithIdentifier:@"logintoprofile" sender:sender];
            } else {
                NSLog(@"User with facebook logged in!");
                NSLog(@"ff%@",permissionsArray);
                [self performSegueWithIdentifier:@"logintoprofile" sender:sender];
            }
        }
    }];
    }
//Sign In Action Button method
-(IBAction)signin:(id)sender{
    PFUser *user = [PFUser user];
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    if(username.length == 0 || password.length == 0){
        NSLog(@"Missing information");
        // Do not move onto next Page,
    }
    else{
        user.username = username;
        user.password = password;
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if(user){
                NSLog(@"login successful");
                AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                ad.storePassword = self.password.text;
                NSLog(@"%@",ad.storePassword);
                [self performSegueWithIdentifier:@"logintoprofile" sender:sender];
                // Now application displays the Profile Page
            }
            else{
                NSLog(@"Log in failed");
                // Ask for re-input of either username or password
            }
        }];

    }
}

-(void) dismissKeyboard {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
