//
//  CreateGroupViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/5/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Parse/PFGeoPoint.h>

@interface CreateGroupViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong,nonatomic) NSArray *array;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *gn;
@property (weak, nonatomic) IBOutlet UITextField *des;
@property (strong,nonatomic) NSArray *categoryIds;
@property (weak,nonatomic) NSNumber *counter;
@property (strong,nonatomic) NSNumber *one;
@property (weak, nonatomic) IBOutlet UISegmentedControl *privacy;
@property (weak,nonatomic) NSNumber *picy;
@property(nonatomic) NSInteger selectedSegmentIndex;
@property (weak, nonatomic) IBOutlet UITextField *txt;
@property (weak, nonatomic) IBOutlet UIImageView *imgGroup;
@property (weak, nonatomic) IBOutlet UIButton *btnEditPicture;

@property NSInteger num;
@property PFGeoPoint* currentLocation;
@end