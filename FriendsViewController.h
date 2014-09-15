//
//  FriendsViewController.h
//  MessageApp
//
//  Created by zoom on 14-4-27.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FriendsViewController : UITableViewController
@property(strong,nonatomic)NSArray * friends;
@property(strong,nonatomic)PFRelation *friendship;
@end
