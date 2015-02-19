//
//  ChatViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/19/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageComposerView = [[MessageComposerView alloc] init];
    self.messageComposerView.delegate = self;
    [self.view addSubview:self.messageComposerView];
    UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *name = [ad.myGlobalArray objectAtIndex:0][@"groupname"];
    self.navbar.title = name;
    PFQuery *member = [PFQuery queryWithClassName:@"Message"];
    [member orderByAscending: @"createdAt"];
    [member whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        self.array = results;
        if([self.array count]!=0) {
            [self.tv setDelegate:self];
            [self.tv setDataSource:self];
            [self.tv reloadData];
            NSIndexPath* ipath = [NSIndexPath indexPathForRow: [self.array count]-1 inSection: 0];
            [self.tv scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
        }
        [NSTimer scheduledTimerWithTimeInterval:5.0f
                                         target:self selector:@selector(check) userInfo:nil repeats:YES];
    }];
    self.originalCenter = self.view.center;
    //self.view.center = CGPointMake(self.view.bounds.size.width, 10);
}

- (void) check {
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    PFQuery *member = [PFQuery queryWithClassName:@"Message"];
    [member orderByAscending: @"createdAt"];
    [member whereKey:@"groupId" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
    [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        self.gId = results;
    }];
    if([self.array count] != [self.gId count]) {
        [self viewDidLoad];
    }

}

-(void) dismissKeyboard {
    [self.chatView endEditing:YES];
   self.view.center = self.originalCenter;
}

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.array count]+4;
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
    if([indexPath row] < [self.array count]) {
        NSString *username = [self.array objectAtIndex: [indexPath row]][@"username"];
        PFUser *currentUser = [PFUser currentUser];
        if([currentUser.username isEqualToString:username]) {
            if (cell != nil) {
                cell = [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = [self.array
                                   objectAtIndex: [indexPath row]][@"message"];
            cell.textLabel.textAlignment = NSTextAlignmentRight;
        }
        else {
            if (cell != nil) {
                cell = [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleSubtitle
                        reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = [self.array
                                   objectAtIndex: [indexPath row]][@"message"];
            cell.detailTextLabel.text = [self.array objectAtIndex: [indexPath row]][@"username"];
        }
    }
    else {
        cell.textLabel.text = @"";
    }
    return cell;
}

- (void)messageComposerSendMessageClickedWithMessage:(NSString*)message {
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    PFObject *chat = [PFObject objectWithClassName:@"Message"];
    PFUser *currentUser = [PFUser currentUser];
    chat[@"username"] = currentUser.username;
    chat[@"message"] = message;
    chat[@"groupId"] = [ad.myGlobalArray objectAtIndex:0][@"groupId"];
    [chat saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
             [self viewDidLoad];
        } else {
            // There was a problem, check error.description
        }
    }];
}

- (IBAction)back:(id)sender {
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

/*- (void)messageComposerFrameDidChange:(CGRect)frame withAnimationDuration:(CGFloat)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0,-10,320,480);
    [UIView commitAnimations];
}*/
/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [ad.myGlobalArray removeAllObjects];
    [ad.myGlobalArray addObject:[self.array objectAtIndex:[indexPath row]]];
    NSLog(@"%@",ad.myGlobalArray);
    [self performSegueWithIdentifier:@"toMyChats" sender:self];
}*/

@end
