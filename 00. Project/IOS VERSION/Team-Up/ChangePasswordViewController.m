//
//  ChangePasswordViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import <Parse/Parse.h>

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*[PFCloud callFunctionInBackground:@"changePassword"
                       withParameters:@{@"Username":@"ksawant",@"NewPassword":@"hello"}
                                block:^(NSString *result, NSError *error) {
                                    if (error) {
                                        NSLog(@"ERROR");
                                        // result is @"Hello world!"
                                    }
                                    else {
                                        NSLog(@"%@",result);
                                    }
                                }];*/
    
}

- (IBAction)reset:(id)sender {
    PFUser *currentuser = [PFUser currentUser];
    NSLog(@"%@",currentuser.email);
    if([self.oldpw.text isEqualToString:currentuser.email]) {
        NSLog(@"email sent");
        [PFUser requestPasswordResetForEmailInBackground:currentuser.email];
    }
    else {
        NSLog(@"fail");
    }
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
