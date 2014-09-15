//
//  loginViewController.h
//  MessageApp
//
//  Created by zoom on 14-4-25.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(id)sender;

@end
