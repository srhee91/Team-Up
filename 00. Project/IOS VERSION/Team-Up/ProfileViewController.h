//
//  ProfileViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *birthdate;
@property (weak, nonatomic) IBOutlet UITextView *des;
@property (weak, nonatomic) IBOutlet UIButton *submit;

@end
