//
//  CategoryTableViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "CategoryTableViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.allCategories = [[NSMutableArray alloc] init];
    self.filteredCategories = [[NSMutableArray alloc] init];
    self.parentCategories = [[NSMutableArray alloc] init];
    
    self.txtSearchBar.delegate = (id)self;
    
    
    
    //Retrieve all categories
    PFQuery *query = [PFQuery queryWithClassName:@"Catogery"];
    [query orderByAscending:@"categoryname"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d categories.", objects.count);
            // Do something with the found objects
            self.allCategories = [objects copy];
            
            //Load filtered categories
            [self pushCategoryAndLoad:@"NULL"];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    // mark the existing preference that are stored in the DB
    //[self markExistingPrefences];
    
    // Do any additional setup after loading the view, typically from a nib.
    //self.cellSelected = [NSMutableArray array];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//Loads the categories with the specified categoryId
- (void)pushCategoryAndLoad:(NSString *)categoryId {
    [self.parentCategories addObject:categoryId];   //Add categoryId to parentCategories stack
    [self filterCategoriesInList:categoryId];       //Filter list with new category id
    
    //Enable back button if there are at least 2 categories in the stack
    if(self.parentCategories.count > 1)
        self.btnBack.enabled = YES;
        
}

//Loads the categories with the categoryId from the top of the parentCategories stack
- (void)popCategoryAndLoad{
    
    //Only allow closing a category if there are at least 2 categories in the stack.
    //This is to prevent removal of the NULL objectId at the bottom of the stack.
    if(self.parentCategories.count > 1){
        [self.parentCategories removeLastObject];
    }
    NSString *parentCategoryId = [self.parentCategories lastObject];
    [self filterCategoriesInList:parentCategoryId];
    
    //Disable back button if there is only 1 category in the stack
    if(self.parentCategories.count == 1)
        self.btnBack.enabled = NO;
}

//Occurs when the back button is pressed
- (IBAction)btnBackPressed:(id)sender {
    [self popCategoryAndLoad];
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    
    if([text isEqualToString:@""]){    //If searchBar is empty, load categories based on parentCategories stack
        [self popCategoryAndLoad];
    } else{ //If search bar has text, only load categories that meet requirements
        self.filteredCategories = [[NSMutableArray alloc] init];
        
        //Loop through all categories, and add categories that contain part of 'text'
        for(PFObject *object in self.allCategories){
            NSString *categoryName = [object objectForKey:@"categoryname"];
            
            NSString *categoryNameAllCaps = [categoryName uppercaseString];
            NSString *searchTextAllCaps = [text uppercaseString];
            
            if([categoryNameAllCaps containsString:searchTextAllCaps])
                [self.filteredCategories addObject:object];
        }
        
    }
    
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)SearchBar{
    [self popCategoryAndLoad];
}

- (void)filterCategoriesInList:(NSString *)parentId{
    
    self.filteredCategories = [[NSMutableArray alloc] init];
    
    //NSLog(@"Looping through %@ categories", self.allCategories.count);
    
    //Loop through all categories, and add the category to the list if parentCategory is its parent
    for (PFObject *category in self.allCategories) {
        NSString *categoryParentId = [[category objectForKey:@"parentCatogery"] objectId];
        if([categoryParentId isEqualToString:parentId]){
            NSLog(@"Adding object with id %@ to filtered categories", category.objectId);
            [self.filteredCategories addObject:category];
        }
    }
    
    //Reload table view
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.filteredCategories count];
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
    //cell.textLabel.text = [self.groups
    //                       objectAtIndex: [indexPath row]];
    cell.textLabel.text = [[self.filteredCategories objectAtIndex:indexPath.row]
                           objectForKey:@"categoryname"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSLog(@"%i",indexPath.row);
    return cell;
}

- (void) tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%i",indexPath.row);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Perform query to check if there are any groups that belong to this category.
    NSString *categoryName = [[self.filteredCategories objectAtIndex:indexPath.row] objectForKey:@"categoryname"];
    NSString *categoryID = [[self.filteredCategories objectAtIndex:indexPath.row] objectId];
    
    //Check if category name is "Teams for You" or "Suggested Groups".  If so, do something else and return early
    if([categoryName isEqualToString:@"Teams for You"]){
        AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        [ad.myGlobalArray removeAllObjects];
        [ad.myGlobalArray addObject:categoryID];
        NSLog(@"%@",ad.myGlobalArray);
        [self performSegueWithIdentifier:@"fromCategoryToTFY" sender:self];
        return;
    } else if([categoryName isEqualToString:@"Closest Groups"]){
        //Segue to 'suggested groups' page
        AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        [ad.myGlobalArray removeAllObjects];
        [ad.myGlobalArray addObject:categoryID];
        NSLog(@"%@",ad.myGlobalArray);
        [self performSegueWithIdentifier:@"fromCategoryToClosestGroups" sender:self];
        return;
    }
    
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Group"];
    [query whereKey:@"category" equalTo:categoryID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d groups.", objects.count);
            
            //If no groups were retrieved, load the next categories to be displayed
            if(objects.count == 0){
                [self pushCategoryAndLoad:categoryID];
                self.searchDisplayController.active = NO;
            } else{ //If groups were retrieved, segue to CategoryGroupViewController to display groups.
                AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                [ad.myGlobalArray removeAllObjects];
                [ad.myGlobalArray addObject:categoryID];
                 NSLog(@"%@",ad.myGlobalArray);
                [self performSegueWithIdentifier:@"fromCategory" sender:self];
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

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
