//
//  ProfileViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

-(void) dismissKeyboard {
    [self.username resignFirstResponder];
    [self.email resignFirstResponder];
    [self.birthdate resignFirstResponder];
    [self.des resignFirstResponder];
    [self.submit resignFirstResponder];
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
