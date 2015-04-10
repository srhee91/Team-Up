//
//  InviteFacebookFriendsViewController.h
//  Team-Up
//
//  Created by YIYANG PAN on 4/10/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//


#import "InviteFacebookFriendsViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface InviteFacebookFriendsViewController ()< FBSDKAppInviteDialogDelegate>

@end

@implementation InviteFacebookFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (IBAction)reset:(id)sender {
    FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] initWithAppLinkURL:[NSURL URLWithString:@"https://fb.me/1589766951307328"]];
    //optionally set previewImageURL
    //content.previewImageURL = [NSURL URLWithString:@"https://www.mydomain.com/my_invite_image.jpg"];
    
    // present the dialog. Assumes self implements protocol `FBSDKAppInviteDialogDelegate`
    
    [FBSDKAppInviteDialog showWithContent:content
                                 delegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FBSDKAppInviteDialogDelegate

- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results
{
    // Intentionally no-op.
}

- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error
{
    NSLog(@"app invite error:%@", error);
    NSString *message = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?:
    @"There was a problem sending the invite, please try again later.";
    NSString *title = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops!";
    
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
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

