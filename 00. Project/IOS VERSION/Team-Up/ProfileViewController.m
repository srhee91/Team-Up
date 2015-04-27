//
//  ProfileViewController.m
//  Team-Up
//
//  Created by Kartik Sawant on 2/3/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    self.un.text = currentUser.username;
    self.em.text = currentUser.email;
    self.bd.text = currentUser[@"birthday"];
    self.des.text = currentUser[@"Description"];
    
    //Load profile image
    PFFile *imgFile = [PFUser currentUser][@"image"];
    UIImage *profilePicture = [UIImage imageWithData:[imgFile getData]];
    if(profilePicture == nil)
        self.imgPicture.image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"QM" ofType:@".jpeg"]];
    else
        [self.imgPicture setImage:profilePicture];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
}

-(void) dismissKeyboard {
    [self.un resignFirstResponder];
    [self.em resignFirstResponder];
    [self.bd resignFirstResponder];
    [self.des resignFirstResponder];
    [self.submit resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)edit:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    if(![self.un.text isEqualToString:@""]&&![self.bd.text isEqualToString:@""]&&![self.em.text isEqualToString:@""]){
        AppDelegate *ad=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        PFUser *user = [PFUser logInWithUsername:currentUser.username password:ad.storePassword];
        user.username = self.un.text;
        user.email = self.em.text;
        user[@"birthday"] = self.bd.text;
        user[@"Description"] = self.des.text;
        [user save];
        [self performSegueWithIdentifier:@"backtoprofile" sender:self];
    }
    else{
        NSLog(@"Missing information");
        //Do not move onto next Page, ask for re-input of information
    }
}

- (IBAction)editPicturePressed:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

//Function called when image is selected from ImagePicker view controller
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    //Set user's profile image
    [self.imgPicture setImage:chosenImage];
    
    //Upload image to parse
    PFUser *currentUser = [PFUser currentUser];
    NSData *imgData = UIImagePNGRepresentation(chosenImage);
    PFFile *pfImage = [PFFile fileWithData:imgData];
    currentUser[@"image"] = pfImage;
    [currentUser saveInBackground];
    
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
