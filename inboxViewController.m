//
//  inboxViewController.m
//  MessageApp
//
//  Created by zoom on 14-4-25.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import "inboxViewController.h"
#import "ImageViewController.h"


@interface inboxViewController ()

@end

@implementation inboxViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
//   //like an  example how to use the parse to send the information to the database
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    self.moviePlayer = [[MPMoviePlayerController alloc] init];
    
    PFUser *currentUser=[PFUser currentUser];
    if (currentUser) {
    }
    else{
        [self performSegueWithIdentifier:@"showLogIn" sender:self];
    }
    
   
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];//select the right message which take the current user as a receiver
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else {
            // We found messages!
            self.messages = objects;
            [self.tableView reloadData];
            NSLog(@"Retrieved %d messages", [self.messages count]);
        }
    }];
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
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.text = [message objectForKey:@"senderName"];
    
    NSString *fileType = [message objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"icon_video"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMessage = [self.messages objectAtIndex:indexPath.row];
    NSString *fileType = [self.selectedMessage objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]) {
        [self performSegueWithIdentifier:@"showImage" sender:self];
    }
    else {
        // File type is video
        PFFile *videoFile = [self.selectedMessage objectForKey:@"file"];
        NSURL *fileUrl = [NSURL URLWithString:videoFile.url];
        self.moviePlayer.contentURL = fileUrl;
        [self.moviePlayer prepareToPlay];
        [self.moviePlayer thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        
        // Add it to the view controller so we can see it
        [self.view addSubview:self.moviePlayer.view];
        [self.moviePlayer setFullscreen:YES animated:YES];
    }
    
    // Delete it!
    NSMutableArray *recipientIds = [NSMutableArray arrayWithArray:[self.selectedMessage objectForKey:@"recipientIds"]];
    NSLog(@"Recipients: %@", recipientIds);
    
    if ([recipientIds count] == 1) {
        // Last recipient - delete!
        [self.selectedMessage deleteInBackground];
    }
    else {
        // Remove the recipient and save
        [recipientIds removeObject:[[PFUser currentUser] objectId]];
        [self.selectedMessage setObject:recipientIds forKey:@"recipientIds"];
        [self.selectedMessage saveInBackground];
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showLogIn"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    else if ([segue.identifier isEqualToString:@"showImage"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        ImageViewController *imageViewController = (ImageViewController *)segue.destinationViewController;
        imageViewController.message = self.selectedMessage;
    }
    
}

- (IBAction)Logout:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogIn" sender:self];
}
@end
