//
//  PrivateProfileViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 4/26/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "PrivateProfileViewController.h"
#import <Parse/Parse.h>

@interface PrivateProfileViewController ()

@end

@implementation PrivateProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    [self.privacyswitch setOn:NO animated:YES];
    if([currentUser[@"Privacy"] isEqualToString: @"True"]) {
        [self.privacyswitch setOn:YES animated:YES];
    }
    [self.privacyswitch addTarget:self action:@selector(switchToggled:) forControlEvents: UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void) switchToggled:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    PFUser *currentUser = [PFUser currentUser];
    if ([mySwitch isOn]) {
        NSLog(@"its on!");
        currentUser[@"Privacy"] =@"True";
    } else {
        NSLog(@"its off!");
        currentUser[@"Privacy"] =@"False";
    }
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }];
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
