//
//  NewUserViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 1/29/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *un;
@property (weak, nonatomic) IBOutlet UITextField *pw;
@property (weak, nonatomic) IBOutlet UITextField *bd;
@property (weak, nonatomic) IBOutlet UITextField *em;
@property (weak, nonatomic) IBOutlet UITextField *loc;
@property (weak, nonatomic) IBOutlet UIButton *signup;

@end
