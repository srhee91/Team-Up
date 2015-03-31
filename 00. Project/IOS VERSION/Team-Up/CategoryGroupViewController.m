//
//  CategoryGroupViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/7/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "CategoryGroupViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
@implementation CategoryGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"In cateogry");
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    PFQuery *group = [PFQuery queryWithClassName:@"Group"];
    [group whereKey:@"category" equalTo:[ad.myGlobalArray objectAtIndex:0]];
    [group findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            self.navbar.title = [results objectAtIndex:0][@"categoryName"];
            self.array = results;
            [self.tv setDelegate:self];
            [self.tv setDataSource:self];
            [self.tv reloadData];
        } else {
            // The find succeeded.
            NSLog(@"failed to retrieve the object.");
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dismissAlert_kick:(UIAlertView *)alertView
{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    sleep(1);
}

- (void)showPopupWithTitle:(NSString *)title
                       msg:(NSString *)message
              dismissAfter:(NSTimeInterval)interval
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:nil
                              ];
    [alertView show];
    [self performSelector:@selector(dismissAlert_kick:)
               withObject:alertView
               afterDelay:interval
     ];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"count of array %d",[self.array count]);
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    cell.textLabel.text = [self.array
                           objectAtIndex: [indexPath row]][@"groupname"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSLog(@"%i",indexPath.row);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Group is Selected");
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [ad.myGlobalArray removeAllObjects];
    [ad.myGlobalArray addObject:[self.array objectAtIndex:[indexPath row]]];

    NSLog(@"%@",ad.myGlobalArray);
    if([ad.myGlobalArray objectAtIndex:0][@"isPublic"]){
        [self performSegueWithIdentifier:@"toGroupProfile" sender:self];
    }
    else{
        [self showPopupWithTitle:@"GROUP PRIVACY INFORMATION" msg: [NSString stringWithFormat:@"%@", @"GROUP IS PRIVATE"] dismissAfter:3];
    }
    
}

@end
