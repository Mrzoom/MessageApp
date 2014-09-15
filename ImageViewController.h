//
//  ImageViewController.h
//  MessageApp
//
//  Created by zoom on 14-4-29.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController
@property (nonatomic, strong) PFObject *message;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
