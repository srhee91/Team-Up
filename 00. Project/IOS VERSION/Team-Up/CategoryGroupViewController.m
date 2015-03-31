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
int *obj;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"In cateogry");
    // Do any additional setup after loading the view.
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [ad.myGlobalArray removeAllObjects];
    [ad.myGlobalArray addObject:[self.array objectAtIndex:[indexPath row]]];
    PFUser *currentUser = [PFUser currentUser];
    PFQuery *member = [PFQuery queryWithClassName:@"Member"];
    [member whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            self.array_temp = results;
        } else {
        }
    }];
    
    PFQuery *group1 = [PFQuery queryWithClassName:@"Group"];
    [group1 whereKey:@"category" equalTo:[ad.myGlobalArray objectAtIndex:0][@"category"]];
    [group1 whereKey:@"groupname" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupname"]];

    [group1 findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            if([[results objectAtIndex:0][@"isPublic"] intValue]==0){
                if(currentUser.username == (NSString*)[ad.myGlobalArray objectAtIndex:0][@"admin"]){
                    NSLog(@"should not be called");
                    [self public];
                }
                else{
                    int i=0;
                    while(i<[self.array_temp count]) {
                        NSLog(@"username %@ %@ %lu", currentUser ,[self.array_temp objectAtIndex:i][@"username"],(unsigned long)[self.array_temp count]);
                        if(currentUser.username == (NSString *)[self.array_temp objectAtIndex:i][@"username"]){
                            NSLog(@"I'm a member");
                            break;
                        }
                        i++;
                    }
                    NSLog(@"count %lu, i = %d", (unsigned long)[self.array_temp count], i);
                    if(i<[self.array_temp count]){
                          NSLog(@"I'm a member verified");
                        [self public];
                    }
                    else if(i == [self.array_temp count]){
                        [self private];
                    }
                }
            }
            else if([[results objectAtIndex:0][@"isPublic"] intValue]==1){
                [self public];
            }
        } else {
            // The find succeeded.
            NSLog(@"failed to retrieve the object.");
        }
    }];
    
}
-(void) private{
     [self showPopupWithTitle:@"GROUP PRIVACY INFORMATION" msg: [NSString stringWithFormat:@"%@", @"GROUP IS PRIVATE"] dismissAfter:3];
}
-(void) public{
    [self performSegueWithIdentifier:@"toGroupProfile" sender:self];
}

@end
