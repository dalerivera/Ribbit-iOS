//
//  DREditFriendsTableViewController.h
//  Ribbit
//
//  Created by Dale Rivera on 7/22/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface DREditFriendsTableViewController : UITableViewController
@property(nonatomic,strong)PFUser *currentUser;
@property(nonatomic,strong)NSArray *allUsers;
@property(nonatomic,strong)NSMutableArray *friends;
- (BOOL) isFriend:(PFUser *)user;
@end
