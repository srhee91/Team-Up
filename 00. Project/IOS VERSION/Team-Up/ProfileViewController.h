//
//  ProfileViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *un;
@property (weak, nonatomic) IBOutlet UITextField *em;
@property (weak, nonatomic) IBOutlet UITextField *bd;
@property (weak, nonatomic) IBOutlet UITextField *des;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIButton *btnEditPicture;
@property (weak, nonatomic) IBOutlet UIImageView *imgPicture;

@end
