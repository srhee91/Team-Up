//
//  3DSPrefTableViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "3DSPrefTableViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface _DSPrefTableViewController ()

@end

@implementation _DSPrefTableViewController

//- (void)addPreferenceToParse {
//    // Push reference changes to the Parse DB
//    PFUser *currentUser = [PFUser currentUser];
//    PFQuery *member = [PFQuery queryWithClassName:@"Preference"];
//    [member orderByDescending: @"createdAt"];
//    [member whereKey:@"username" notEqualTo:currentUser.username];
//    [member whereKey:@"categoryname" equalTo:[ad.myGlobalArray objectAtIndex:0][@"groupId"]];
//    [member findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
//        //Save button
//        self.navbar.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
//        if (!error) {
//            self.array = results;
//            NSLog(@"Successfully push to the DB");
//            [self.tv setDelegate:self];
//            [self.tv setDataSource:self];
//            [self.tv reloadData];
//        } else {
//            // The find succeeded.
//            NSLog(@"failed to retrieve the object.");
//        }
//
//    }];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        self.groups = [[NSArray alloc]
                       initWithObjects:@"Animal Crossing: New Leaf",@"Mario Kart 7", @"Need for Speed: The Run", @"Pokemon Omega Ruby and Alpha Sapphire", @"Pokemon X/Y", @"Super Smash Bros. for 3DS", nil];
    
    
//        PFQuery *query = [PFQuery queryWithClassName:@"Category"];
//        [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (!error) {
//                // The find succeeded.
//                NSLog(@"Successfully retrieved %d scores.", objects.count);
//                // Do something with the found objects
//                for (PFObject *object in objects) {
//                    NSLog(@"%@", object.objectId);
//                    self.categories.addObject
//                }
//            } else {
//                // Log details of the failure
//                NSLog(@"Error: %@ %@", error, [error userInfo]);
//            }
//        }];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Do any additional setup after loading the view, typically from a nib.
    self.cellSelected = [NSMutableArray array];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.groups count];
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
    cell.textLabel.text = [self.groups
                           objectAtIndex: [indexPath row]];
    
    // Add check mark when cells are selected
    if ([self.cellSelected containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //cell.addPreferenceToParse //TODO
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        //cell.removePreferenceFromParse //TODO
    }
    NSLog(@"%i",indexPath.row);
    return cell;
}

- (void) tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%i",indexPath.row);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //if you want only one cell to be selected use a local NSIndexPath property instead of array. and use the code below
    //self.selectedIndexPath = indexPath;
    
    //the below code will allow multiple selection
    if ([self.cellSelected containsObject:indexPath])
    {
        [self.cellSelected removeObject:indexPath];
        //[self removePreferenceFromParse];
    }
    else
    {
        [self.cellSelected addObject:indexPath];
        //[self addPreferenceToParse];
    }
    [tableView reloadData];
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 Configure the cell...
 
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
