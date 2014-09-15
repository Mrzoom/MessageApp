//
//  CameraViewController.h
//  MessageApp
//
//  Created by zoom on 14-4-27.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CameraViewController : UITableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(strong,nonatomic)UIImagePickerController *imagePicker;
@property(strong,nonatomic)UIImage *image;
@property(strong,nonatomic)NSString *videoPath;
@property(strong,nonatomic)NSMutableArray *recipents;
@property(strong,nonatomic)PFRelation *friendship;
@property(strong,nonatomic)NSArray * friends;
- (IBAction)send:(id)sender;
- (IBAction)cancel:(id)sender;
-(void) uploadMessage;
-(UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height;
@end
