//
//  NewUserViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 1/29/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "NewUserViewController.h"
#import "Parse/parse.h"//;

@interface NewUserViewController ()

@end

@implementation NewUserViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)signup:(id)sender {
    PFUser *user = [PFUser user];

    NSString *username = self.un.text;
    user.username = username;
    NSString *password = self.pw.text;
    user.password = password;
    NSString *password2 = self.newpw.text;
    NSString *birthdate = self.bd.text;
    NSString *email = self.em.text;
    NSString *location = self.loc.text;
    if(username == nil || password == nil){
        printf("something went wrong re input ");
    }
    else {
     /*   [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                //The registration was successful, go to the wall
                [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
                
            } else {
                //Something bad has occurred
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorAlertView show];
            }
        }];*/
    }
   
}


@end
