//
//  signUpViewController.h
//  MessageApp
//
//  Created by zoom on 14-4-25.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface signUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;
- (IBAction)signUpButton:(id)sender;
- (IBAction)dismiss:(id)sender;

@end
