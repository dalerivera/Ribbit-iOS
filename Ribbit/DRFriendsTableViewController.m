//
//  DRFriendsTableViewController.m
//  Ribbit
//
//  Created by Dale Rivera on 7/22/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import "DRFriendsTableViewController.h"
#import "DREditFriendsTableViewController.h"
#import "GravatarUrlBuilder.h"
@interface DRFriendsTableViewController ()

@end

@implementation DRFriendsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }else {
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        //get email
        NSString *email = [user objectForKey:@"email"];
        //create MD5 hash
        NSURL *gravatarUrl = [GravatarUrlBuilder getGravatarUrl:email];
        //request image
        NSData *imageData = [NSData dataWithContentsOfURL:gravatarUrl];
        if(imageData!= nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //set image
                cell.imageView.image = [UIImage imageWithData:imageData];
                [cell setNeedsLayout];
            });
        }
        
    });
    cell.imageView.image = [UIImage imageNamed:@"icon_person"];
    cell.textLabel.text = user.username;
    UIImageView *image = [UIImageView alloc]initWithImage:<#(UIImage *)#>
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showEditFriends"]) {
        DREditFriendsTableViewController *viewController = ((DREditFriendsTableViewController *)segue.destinationViewController);
        viewController.friends = [NSMutableArray arrayWithArray:self.friends];
    }
}


@end
