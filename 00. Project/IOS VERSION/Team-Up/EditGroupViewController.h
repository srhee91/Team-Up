//
//  EditGroupViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/8/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditGroupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *gn;
@property (weak, nonatomic) IBOutlet UITextField *des;
@property (weak, nonatomic) IBOutlet UIImageView *imgGroup;
@property (weak, nonatomic) IBOutlet UITextField *txt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *privacy;
@property (weak, nonatomic) IBOutlet UIButton *edit;
@property (weak, nonatomic) IBOutlet UIButton *btnEditPicture;
@property (weak,nonatomic) NSNumber *picy;
@end
