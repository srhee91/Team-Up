//
//  GroupMeetingsViewController.m
//  Team-Up
//
//  Created by Travis on 3/20/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "GroupMeetingsViewController.h"
#import "ScheduleMeetingViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface GroupMeetingsViewController ()

@end

@implementation GroupMeetingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self.scheduleButton setTitle:@""];
    self.scheduleButton.enabled = NO;
    PFUser *currentUser = [PFUser currentUser];
    PFQuery *meetings = [PFQuery queryWithClassName:@"Meeting"];
    NSDate *today = [NSDate date];
    [meetings orderByAscending:@"date"];
    [meetings whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [meetings whereKey:@"date" greaterThan:today];
    [meetings findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        self.array = results;
        [self.tv setDelegate:self];
        [self.tv setDataSource:self];
        [self.tv reloadData];
    }];
    
    if([currentUser.username isEqualToString:[ad.myGlobalArray objectAtIndex:0][@"admin"]]) {
        [self.scheduleButton setTitle:@"+"];
        self.scheduleButton.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)unwindToMeetings:(UIStoryboardSegue *)segue {
    
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];

    NSDate *today = [NSDate date];
    PFQuery *meetings = [PFQuery queryWithClassName:@"Meeting"];
    [meetings orderByAscending:@"date"];
    [meetings whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [meetings whereKey:@"date" greaterThan:today];
    [meetings findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        self.array = results;
        [self.tv setDelegate:self];
        [self.tv setDataSource:self];
        [self.tv reloadData];
    }];
    
    
    NSLog(@"UNWINDED");

}

- (IBAction)unwindBlank:(UIStoryboardSegue *)segue {
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    NSDate *today = [NSDate date];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel *mainLabel, *secondLabel;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
        
        mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0,0.0,220.0,15.0)];
        mainLabel.textAlignment = NSTextAlignmentLeft;
        mainLabel.textColor = [UIColor blackColor];
        mainLabel.font = [UIFont systemFontOfSize:14.0];
        [cell.contentView addSubview:mainLabel];
        
        secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0,20.0,220.0,25.0)];
        secondLabel.textAlignment = NSTextAlignmentLeft;
        secondLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:secondLabel];
        
    }
    
    //cell.textLabel.text = [self.array objectAtIndex:[indexPath row]][@"title"];
    mainLabel.text = [self.array objectAtIndex:[indexPath row]][@"title"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *meetingDate = [self.array objectAtIndex:[indexPath row]][@"date"];
    secondLabel.text = [dateFormatter stringFromDate:meetingDate];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
