//
//  ChatViewController.h
//  Team-Up
//
//  Created by Kartik Sawant on 2/19/15.
//  Copyright (c) 2015 Kartik Sawant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageComposerView.h"

@interface ChatViewController : UIViewController<MessageComposerViewDelegate>
@property (nonatomic, strong) MessageComposerView *messageComposerView;
@property (strong, nonatomic) IBOutlet UIView *chatView;
@property (strong,nonatomic) NSArray *gId;
@property (strong, nonatomic) NSArray *array;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
@property (nonatomic) CGPoint originalCenter;
@end
