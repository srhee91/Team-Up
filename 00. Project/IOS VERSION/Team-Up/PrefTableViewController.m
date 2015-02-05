//
//  PrefTableViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/5/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "PrefTableViewController.h"

@interface PrefTableViewController ()

@end

@implementation PrefTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.section1 = [[NSArray alloc]
                         initWithObjects:@"Counter-Strike: Global Offensive",@"Diablo III", @"Dota 2", @"League of Legends", @"Minecraft", @"Starcraft 2", @"World of Warcraft", nil];
    self.section2 = [[NSArray alloc]
                         initWithObjects:@"Borderlands",@"Call of Duty: Black Ops", @"Dark Souls II", @"FIFA 15", @"Grand Theft Auto V", nil];
    self.section3 = [[NSArray alloc]
                         initWithObjects:@"Call of Duty: Advanced Warfare",@"Call of Duty: Ghosts", @"FIFA 15", @"Grand Theft Auto V", @"The Last of Us", nil];
    self.section4 = [[NSArray alloc]
                         initWithObjects:@"Assassin's Creed",@"Destiny", @"FIFA 15", @"Grand Theft Auto V", @"Minecraft", nil];
    self.section5 = [[NSArray alloc]
                         initWithObjects:@"Call of Duty: Advanced Warfare", @"FIFA 15", @"Grand Theft Auto V", @"Halo: Master Chief Collection", @"Titanfall", nil];
    self.section6 = [[NSArray alloc]
                         initWithObjects:@"Call of Duty: Black Ops",@"Mario Kart 8", @"Monster Hunter", @"Super Mario 3D World", @"Super Smash Bros. for Wii U", nil];
    self.section7 = [[NSArray alloc]
                         initWithObjects:@"Animal Crossing: New Leaf",@"Mario Kart 7", @"Need for Speed: The Run", @"Pokemon Omega Ruby and Alpha Sapphire", @"Pokemon X/Y", @"Super Smash Bros. for 3DS", nil];
    self.section8 = [[NSArray alloc]
                         initWithObjects:@"Basketball",@"Bowling", @"Dance", @"Football", @"Golf", @"Hockey", @"Lifting", @"Running", @"Soccer", @"Tennis", @"Volleyball", nil];
    
    self.array = [[NSMutableArray alloc] initWithObjects:self.section1, self.section2, self.section3, self.section4, self.section5, self.section6, self.section7, self.section8, nil];
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if(section == 0) return [self.section1 count];
    if(section == 1) return [self.section2 count];
    if(section == 2) return [self.section3 count];
    if(section == 3) return [self.section4 count];
    if(section == 4) return [self.section5 count];
    if(section == 5) return [self.section6 count];
    if(section == 6) return [self.section7 count];
    if(section == 7) return [self.section8 count];
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //For each section, return header label
    if(section == 0) return @"PC";
    if(section == 1) return @"PlayStation 3";
    if(section == 2) return @"PlayStation 4";
    if(section == 3) return @"Xbox 360";
    if(section == 4) return @"Xbox One";
    if(section == 5) return @"Nintendo Wii U";
    if(section == 6) return @"Nintendo 3DS";
    if(section == 7) return @"Sports";
    return nil;
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
    cell.textLabel.text = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSNumber *rowNsNum = [NSNumber numberWithUnsignedInt:indexPath.row];
    if ( [self.array containsObject:rowNsNum]  )
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        //cell.accessoryType = UITableViewCellAccessoryNone;
    //}
    //else {
    //    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //}
    NSLog(@"%i",indexPath.row);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.checkedIndexPath = indexPath;
    
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([selectedCell accessoryType] == UITableViewCellAccessoryNone || [selectedCell accessoryType]== UITableViewCellAccessoryDisclosureIndicator)
    {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self.array addObject:[self.array objectAtIndex:indexPath.row]];
    }
    else
    {
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
        [self.array removeObject:[NSNumber numberWithInt:indexPath.row]];
    }
    
    /*int row = indexPath.row;
    int section = indexPath.section;
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    [tableView deselectRowAtIndexPath:newIndexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:newIndexPath];
    
    //NSArray *arrays = [self.array objectAtIndex:indexPath.section];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }*/
    //[tableView reloadData];
    /*UITableViewCell *theCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (theCell.accessoryType == UITableViewCellAccessoryNone) {
        theCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    else if (theCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        theCell.accessoryType = UITableViewCellAccessoryNone;
    }*/
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
