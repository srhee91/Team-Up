//
//  DownloadPictureViewController.m
//  Team-Up
//
//  Created by Travis on 3/27/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "DownloadPictureViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface DownloadPictureViewController ()

@property NSString *groupName;
@property NSString *groupId;

@end

@implementation DownloadPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Get global variables
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //Load group image
    ad.currentGroupImage = [UIImage imageWithData:[[ad.myGlobalArray objectAtIndex:0][@"image"] getData]];
    if(ad.currentGroupImage == nil)
        ad.currentGroupImage = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"QM" ofType:@".jpeg"]];
    [self.imgGroup setImage:ad.currentGroupImage];
    
    //Load group name/id
    self.groupName = [ad.myGlobalArray objectAtIndex:0][@"groupname"];
    self.groupId = [ad.myGlobalArray objectAtIndex:0][@"objectid"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)downloadButtonPressed:(id)sender {
    NSString *stringURL = self.txtUrl.text;
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    NSString *fileName = [NSString stringWithFormat:@"%@%@", self.groupName, @".png"];

    
    if ( urlData )
    {
        //Attempt to parse image from data
        UIImage *image = [UIImage imageWithData:urlData];
        
        //Determine location of user's documents directory
        NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        //Save file in the user's documents with the name '<groupName>.png'
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,fileName];
        [urlData writeToFile:filePath atomically:YES];
        
        //Set current group image
        AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        ad.currentGroupImage = image;
        [self.imgGroup setImage:image];
        
        //Upload image to parse
        PFFile *pfImage = [PFFile fileWithData:urlData];
        [ad.myGlobalArray objectAtIndex:0][@"image"] = pfImage;
        [[ad.myGlobalArray objectAtIndex:0] saveInBackground];
    }
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
