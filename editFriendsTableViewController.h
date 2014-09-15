//
//  editFriendsTableViewController.h
//  MessageApp
//
//  Created by zoom on 14-4-27.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface editFriendsTableViewController : UITableViewController
@property(strong, nonatomic)NSArray * users;
@property(strong,nonatomic) PFUser * currentUser;
@property(strong,nonatomic)NSMutableArray *friends;

-(BOOL)isFriend:(PFUser *)user;
@end
