//
//  inboxViewController.h
//  MessageApp
//
//  Created by zoom on 14-4-25.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>


@interface inboxViewController : UITableViewController
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) PFObject *selectedMessage;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

- (IBAction)Logout:(id)sender;

@end
