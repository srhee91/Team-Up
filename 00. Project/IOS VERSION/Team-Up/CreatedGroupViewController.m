//
//  CreatedGroupViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/6/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "CreatedGroupViewController.h"
#import <Parse/Parse.h>
@interface CreatedGroupViewController ()

@end

@implementation CreatedGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    PFQuery *group = [PFQuery queryWithClassName:@"Group"];
    [group orderByDescending: @"createdAt"];
    [group whereKey:@"admin" equalTo:currentUser.username];
    [group getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            self.navbar.title = object[@"groupname"];
            self.navbar.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStylePlain target:self action:@selector(modal)];
            self.gn.text = object[@"groupname"];
            self.an.text = object[@"admin"];
            self.cat.text = object[@"categoryName"];
            self.des.text = object[@"description"];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
}

- (void)modal {
    [self performSegueWithIdentifier:@"profile" sender:self];
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
