//
//  CreateGroupViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/5/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "CreateGroupViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
@interface CreateGroupViewController ()

@end

@implementation CreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txt.enabled = NO;
    
    //Initialize current location to some default geopoint value
    self.currentLocation = [[PFGeoPoint alloc] init];
    
    
    // get user's current location
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            // do something with the new geoPoint
            // User's location
            self.currentLocation = geoPoint;
            
        }
    }];
    
    PFQuery *groups = [PFQuery queryWithClassName:@"Group"];
    [groups orderByDescending: @"createdAt"];
    [groups getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
            self.counter = [NSNumber numberWithInt:0];
        } else {
            // The find succeeded.
            NSLog(@"got the object.");
            self.counter = object[@"groupId"];
        }
    }];
    self.array = [[NSArray alloc]
                  initWithObjects:@"Counter-Strike: Global Offensive",@"Diablo III", @"Dota 2", @"League of Legends", @"Minecraft (PC)", @"Starcraft 2", @"World of Warcraft", @"Borderlands",@"Call of Duty: Black Ops (PS3)", @"Dark Souls II", @"FIFA 15 (PS3)", @"Grand Theft Auto V (PS3)", @"Call of Duty: Advanced Warfare",@"Call of Duty: Ghosts", @"FIFA 15 (PS4)", @"Grand Theft Auto V (PS4)", @"The Last of Us", @"Assassin's Creed",@"Destiny", @"FIFA 15 (Xbox 360)", @"Grand Theft Auto V (Xbox 360)", @"Minecraft", @"Call of Duty: Advanced Warfare", @"FIFA 15 (Xbox One)", @"Grand Theft Auto V (Xbox One)", @"Halo: Master Chief Collection", @"Titanfall", @"Call of Duty: Black Ops (Wii U)",@"Mario Kart 8", @"Monster Hunter", @"Super Mario 3D World", @"Super Smash Bros. for Wii U", @"Animal Crossing: New Leaf",@"Mario Kart 7", @"Need for Speed: The Run", @"Pokemon Omega Ruby and Alpha Sapphire", @"Pokemon X/Y", @"Super Smash Bros. for 3DS", @"Basketball",@"Bowling", @"Dance", @"Football", @"Golf", @"Hockey", @"Lifting", @"Running", @"Soccer", @"Tennis", @"Volleyball", @"Other", nil];
    self.categoryIds = [[NSArray alloc]
                  initWithObjects:@"Y08m3Bk2ML",@"OYzE67DLJY", @"hAst9NlM7B", @"5s6t3QOnus", @"kFX8ng3JKP", @"pZJ7IQ2354", @"a8OwaLHwl9", @"wL7AUqQZzh",@"O2PKmIfD2S", @"6FhvX3AwZh", @"YLCvbqcPwv", @"C6ts4k4A1V", @"T9jwH1ey8E",@"82vXN1J9Of", @"o5k5D9yIi9", @"APaiUgjILJ", @"lQXBaXXIfX", @"OJS5QqzpR7",@"9xjg4FpOyp", @"12hTVqTqd9", @"cJt81g4L2u", @"mbRN1g5IXI", @"sIaH6onOyV", @"YRTYpaeS1r", @"jxkD5gvjpN", @"6TW8l71zHP", @"7PCwfnWU9N", @"J9FW17h0vG",@"iYsvijsXEi", @"HH8gn7RrWa", @"jsSQCQHbkH", @"cOhmCtZbaz", @"v7IvgXAxMb",@"nJz8dxqWB7", @"501cCWxX1O", @"PVmDf5LorGK", @"xN02mxzNdU", @"jzq16IKP5x", @"3JnaDl86bH",@"2BhHEQp7rp", @"iLLmAbaI7N", @"y9LKvRhAZO", @"zESMkkCUn9", @"E8U96BO7Rj", @"HzsirFtnlN", @"R3y0nzWFY3", @"0ibvHNlvcP", @"jMY37MfYlN", @"HUEv421bbF", @"2gyBcWjaY9", nil];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}


-(void) dismissKeyboard {
    [self.picker resignFirstResponder];
    [self.gn resignFirstResponder];
    [self.des resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1; // For one column
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.array count]; // Numbers of rows
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.array objectAtIndex:row]; // If it's a string
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        //[tView setTextAlignment:UITextAlignmentLeft];
        tView.numberOfLines=1;
    }
    // Fill the label text here
    tView.text=[self.array objectAtIndex:row];
    return tView;
}
- (IBAction)privacySetting:(id)sender {
    if(self.privacy.selectedSegmentIndex == 0){
        NSLog(@"YES");
    }
    else if(self.privacy.selectedSegmentIndex == 1){
        NSLog(@"NO");
    }
}

-(IBAction)submit:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    PFObject *group = [PFObject objectWithClassName:@"Group"];
    group[@"admin"] = currentUser.username;
    group[@"groupname"] = self.gn.text;
    NSInteger selectedRow = [self.picker selectedRowInComponent:0];
    NSString *categoryId = [self.categoryIds objectAtIndex:selectedRow];
    NSString *categoryname = [self.array objectAtIndex:selectedRow];
    group[@"category"] = categoryId;
    group[@"categoryName"] = categoryname;
    group[@"description"] = self.des.text;
    group[@"image"] = [PFFile fileWithData:UIImagePNGRepresentation(self.imgGroup.image)];
    
    if(self.privacy.selectedSegmentIndex == 0){
        group[@"isPublic"] = [NSNumber numberWithBool:YES];
    }
    else if(self.privacy.selectedSegmentIndex == 1){
        group[@"isPublic"] = [NSNumber numberWithBool:NO];
    }
    else{
        group[@"isPublic"] = [NSNumber numberWithBool:YES];
    }

    group[@"geoPoint"] = self.currentLocation;
	
    self.one = [NSNumber numberWithInt:1];
    group[@"groupId"] = [NSNumber numberWithFloat:([self.one intValue] + [self.counter intValue])];
    
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [ad.myGlobalArray setObject:group atIndexedSubscript:0];
    
    
    PFObject *member = [PFObject objectWithClassName:@"Member"];
    member[@"username"] = currentUser.username;
    member[@"groupId"] = [NSNumber numberWithFloat:([self.one intValue] + [self.counter intValue])];
    [member saveInBackground];
    [group saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"yay");
            [self performSegueWithIdentifier:@"showgroupmade" sender:sender];
        } else {
            // There was a problem, check error.description
            NSLog(@"%@",error.description);
        }
    }];
}
- (IBAction)editPictureClick:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

//Function called when image is selected from ImagePicker view controller
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imgGroup.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    //Set current group image
    AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    ad.currentGroupImage = chosenImage;
    [self.imgGroup setImage:chosenImage];
    
    //Upload image to parse
    //NSData *imgData = UIImagePNGRepresentation(chosenImage);
    //PFFile *pfImage = [PFFile fileWithData:imgData];
    //[ad.myGlobalArray objectAtIndex:0][@"image"] = pfImage;
    //[[ad.myGlobalArray objectAtIndex:0] saveInBackground];
    
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
