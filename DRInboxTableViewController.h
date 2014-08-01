//
//  DRInboxTableViewController.h
//  Ribbit
//
//  Created by Dale Rivera on 7/22/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>
@interface DRInboxTableViewController : UITableViewController
@property(nonatomic,strong) NSArray *messages;
@property(nonatomic,strong)PFObject *selectedMessage;
@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@end
