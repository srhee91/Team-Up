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
    user.email = email;
    if ([password compare:password2 options:NSCaseInsensitiveSearch] == NSOrderedSame){
            if(username.length!=0&&password.length!=0&&password2.length!=0&&birthdate.length!=0&&email.length!=0){
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        NSLog(@"successfull");
                        // Now Sign Up successful, continue to onto next page
                    } else {
                        // Sign Up failed, ask for re-input of user information
                        NSString *errorString = [[error userInfo] objectForKey:@"error"];
                        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [errorAlertView show];
                    }
                }];
            }
            else{
                NSLog(@"Missing information");
                //Do not move onto next Page, ask for re-input of information
            }
    }
    else{
        NSLog(@"pass not equal");
        //Do not move onto next Page, ask for re-input of passwords
    }
    
}


@end
