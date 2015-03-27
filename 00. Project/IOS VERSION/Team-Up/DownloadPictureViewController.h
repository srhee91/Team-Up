//
//  DownloadPictureViewController.h
//  Team-Up
//
//  Created by Travis on 3/27/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadPictureViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtUrl;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@end
