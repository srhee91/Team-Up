//
//  ChangePasswordViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldpw;
@property (weak, nonatomic) IBOutlet UITextField *newpw;
@property (weak, nonatomic) IBOutlet UITextField *conpw;
@property (weak, nonatomic) IBOutlet UIButton *reset;

@end
