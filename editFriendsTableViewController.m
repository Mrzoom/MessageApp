//
//  editFriendsTableViewController.m
//  MessageApp
//
//  Created by zoom on 14-4-27.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import "editFriendsTableViewController.h"
#import <Parse/Parse.h>
#import "loginViewController.h"

@interface editFriendsTableViewController ()

@end

@implementation editFriendsTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFQuery *query=[PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@ %@",error, [error userInfo]);
        }
        else{
            self.users=objects;
            [self.tableView reloadData];//when we get the data, let it show in the tableview. bc the data gets asynchnoise !!!!!tableView is the property for every tableview controller instance
        }
    }];
    self.currentUser = [PFUser currentUser];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.users count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//the dequeueReusableCellWithIdentifier:@"Cell" should match the attribut in the storyboard!!!
    PFUser *user = self.users[indexPath.row];
    cell.textLabel.text=user.username;
    if ([self isFriend:user]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO]; //used when we select the cell, it will not always highlight.
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    PFUser *user =self.users[indexPath.row];
    PFRelation *friendship=[self.currentUser relationForKey:@"friendship"];//this key is useful when we want to get the PFRelation property
    
    if ( [self isFriend:user]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [friendship removeObject:user];
        for (PFUser*_user in self.friends) {
            if ([_user.objectId isEqualToString:user.objectId]) {
                [self.friends removeObject:_user];
                break;
            }
        }
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [friendship addObject:user];
        [self.friends addObject:user];
    }
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"%@ %@", error, [error userInfo]);
        }
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)isFriend:(PFUser *)user
{
    for (PFUser* _user in self.friends) {
        if ([_user.objectId isEqualToString:user.objectId]) {
            return YES;
        }
    }
    return NO;
}

@end
