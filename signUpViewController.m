
//
//  signUpViewController.m
//  MessageApp
//
//  Created by zoom on 14-4-25.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import "signUpViewController.h"
#import <Parse/Parse.h>

@interface signUpViewController ()

@end

@implementation signUpViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signUpButton:(id)sender {
    NSString *username =[self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password =[self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email =[self.emailAddressField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([username length]==0||[password length]==0||[email length]==0){
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter usename, password and email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        PFUser *user=[PFUser user];
        user.username=username;
        user.password=password;
        user.email=email;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {///this is an asynchronise mechnaism
            if(error){
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
}

- (IBAction)dismiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
