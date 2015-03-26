//
//  MemberTableViewController.m
//  Team-Up
//
//  Created by Bo heon Jeong on 3/22/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "MemberTableViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface MemberTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *MV;
@property (strong, nonatomic) NSString *admin;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) AppDelegate *ad;

@end

@implementation MemberTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self setModalPresentationStyle:UIModalPresentationCurrentContext];
    self.ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.admin = [self.ad.myGlobalArray objectAtIndex:0][@"admin"];
    PFQuery *member = [PFQuery queryWithClassName:@"Member"];
    PFUser *currentUser = [PFUser currentUser];

    [member orderByDescending: @"createdAt"];
    [member whereKey:@"username" notEqualTo:currentUser.username];
    [member whereKey:@"groupId" equalTo:[self.ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            self.array = results;
            NSLog(@"made fff");
            [self.MV setDelegate:self];
            [self.MV setDataSource:self];
            [self.MV reloadData];
        } else {
            // The find succeeded.
        }
        PFQuery *members = [PFQuery queryWithClassName:@"Member"];
        [members whereKey:@"groupId" equalTo:[self.ad.myGlobalArray objectAtIndex:0][@"groupId"]];
        [members findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        }];
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.array count];
}

- (IBAction)admin:(id)sender {
    self.name = [self.array
                      objectAtIndex: [sender tag]][@"username"];
    PFQuery *groups = [PFQuery queryWithClassName:@"Group"];
    [groups whereKey:@"groupId" equalTo:[self.ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [groups getFirstObjectInBackgroundWithBlock:^(PFObject * object, NSError *error) {
        if (!error) {
            [object setObject:self.name forKey:@"admin"];
            [object saveInBackground];
        } else {
             NSLog(@"Error: %@", error);
        }
    }];
    

}
- (void)toAdmin {
    [self performSegueWithIdentifier:@"toAdmin" sender:self];
}
- (IBAction)kick:(id)sender {
    self.name = [self.array
                      objectAtIndex: [sender tag]][@"username"];
    PFQuery *members = [PFQuery queryWithClassName:@"Member"];
    [members whereKey:@"groupId" equalTo:[self.ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [members whereKey:@"username" equalTo: self.name];
    [members getFirstObjectInBackgroundWithBlock:^(PFObject * object, NSError *error) {
        if (!error) {
            [object deleteInBackground];
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
                           objectAtIndex: [indexPath row]][@"username"];

    
    UIButton *adminbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [adminbutton addTarget:self
               action:@selector(admin:)
     forControlEvents:UIControlEventTouchDown];
    [adminbutton setTitle:@"ADMIN" forState:UIControlStateNormal];
     adminbutton.frame = CGRectMake(225.0f, 5.0f, 50.0f, 30.0f);
    [adminbutton addTarget:self action:@selector(admin:) forControlEvents:UIControlEventTouchUpInside];
    [adminbutton setTag:indexPath.row];
    [cell addSubview:adminbutton];
    [adminbutton addTarget:self
                        action:@selector(toAdmin)
              forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *kickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [kickButton addTarget:self
                    action:@selector(kick:)
          forControlEvents:UIControlEventTouchDown];
    [kickButton setTitle:@"KICK" forState:UIControlStateNormal];
    kickButton.frame = CGRectMake(300.0f, 5.0f, 50.0f, 30.0f);
    [cell addSubview:kickButton];
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
    }
}*/

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
