//
//  AdminPopupViewController.m
//  Team-Up
//
//  Created by Bo heon Jeong on 3/26/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "AdminPopupViewController.h"

@interface AdminPopupViewController ()

@end

@implementation AdminPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)ok:(id)sender {
    [self dismissViewControllerAnimated:YES completion: nil];
}

@end
