//
//  DRCameraTableViewController.h
//  Ribbit
//
//  Created by Dale Rivera on 7/24/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface DRCameraTableViewController : UITableViewController
@property(nonatomic,strong)UIImagePickerController *imagePicker;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *videoFilePath;
@property(nonatomic,strong) PFRelation *friendsRelation;
@property(nonatomic,strong)NSArray *friends;
@property(nonatomic,strong)NSMutableArray *recepients;
@end
