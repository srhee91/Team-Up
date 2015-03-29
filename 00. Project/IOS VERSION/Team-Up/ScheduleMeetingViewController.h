//
//  ScheduleMeetingViewController.h
//  Team-Up
//
//  Created by Trevor on 3/11/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ScheduleMeetingViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIDatePicker *picker;
@property (weak, nonatomic) IBOutlet UITextField *purpose;
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

@end
