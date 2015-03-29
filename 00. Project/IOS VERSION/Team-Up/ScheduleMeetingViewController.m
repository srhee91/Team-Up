//
//  ScheduleMeetingViewController.m
//  Team-Up
//
//  Created by Trevor on 3/11/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "ScheduleMeetingViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface ScheduleMeetingViewController ()
/*@property (weak, nonatomic) IBOutlet UINavigationItem *cancelButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *submitButton;*/

@end

@implementation ScheduleMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendMeeting:(id)sender {
    if([self.purpose.text length] == 0) {
        NSLog(@"EMPTY STRING");
        return;
    }
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    PFObject *meeting = [PFObject 	objectWithClassName:@"Meeting"];
    meeting[@"title"] = self.purpose.text;
    meeting[@"date"] = self.picker.date;
    meeting[@"groupId"] = [ad.myGlobalArray objectAtIndex:0][@"groupId"];
    
    //[meeting saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    [meeting save];
    NSLog(@"SUCCEEDED!?");
    
    //[self performSegueWithIdentifier:@"unwindToMeetings" sender:self];
    [self performSegueWithIdentifier:@"unwindToMeetings" sender:self];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (IBAction)cancel:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)testFunction:(id)sender {
    int i = 0;
    i++;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if(sender != self.submitButton) {
        return;
    }
}


@end
