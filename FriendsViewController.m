//
//  FriendsViewController.m
//  MessageApp
//
//  Created by zoom on 14-4-27.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import "FriendsViewController.h"
#import "editFriendsTableViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.friendship=[[PFUser currentUser] objectForKey:@"friendship"];
//    self.friendship=[[PFUser currentUser] objectForKey:@"friendship"];
//    PFQuery *query =[self.friendship query];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error) {
//            NSLog(@"%@ %@",error, [error userInfo]);
//        }
//        else{
//            self.friends = objects;
//            [self.tableView reloadData]; 
//        }
//    }];
//    [self.tableView reloadData]; //put it here, we cannot get the result show in the friend table view. bc the block code is running asynchnoise. So we should wait until we get the data then reload
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    PFQuery *query =[self.friendship query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@ %@",error, [error userInfo]);
        }
        else{
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];
}

//using this methon to share the data with different views
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"editFriends"]) {
        editFriendsTableViewController * viewController= (editFriendsTableViewController *)segue.destinationViewController;
        viewController.friends=[NSMutableArray arrayWithArray:self.friends];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFUser *user=self.friends[indexPath.row];
    cell.textLabel.text=user.username;
    
    return cell;
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

@end
