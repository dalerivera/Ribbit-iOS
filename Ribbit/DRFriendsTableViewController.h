//
//  DRFriendsTableViewController.h
//  Ribbit
//
//  Created by Dale Rivera on 7/22/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface DRFriendsTableViewController : UITableViewController
@property(nonatomic,strong)PFRelation *friendsRelation;
@property(nonatomic,strong)NSArray *friends;
@end
